resource "random_password" "db" {
  length  = 24
  special = false
}

resource "random_uuid" "db_snapshot_id" {}

resource "aws_ssm_parameter" "db_password" {
  name      = "/${var.environment_name}/rds/db/password"
  type      = "SecureString"
  value     = random_password.db.result
  overwrite = true

  tags = var.tags
}

resource "aws_kms_key" "aurora_cluster_encryption_key" {
  description             = "${var.environment_name} key"
  deletion_window_in_days = 10
  enable_key_rotation     = true

  tags = var.tags
}

resource "aws_kms_alias" "aurora_cluster_encryption_key_alias" {
  target_key_id = aws_kms_key.aurora_cluster_encryption_key.id
  name          = "alias/${var.environment_name}-aurora-cluster"
}

resource "aws_rds_cluster_parameter_group" "default" {
  name_prefix = "${var.environment_name}-parameter-group"
  description = "The configuration for Bichard PostgreSQL"
  family      = "aurora-postgresql13"

  parameter {
    name         = "max_prepared_transactions"
    value        = "100"
    apply_method = "pending-reboot"
  }

  parameter {
    name         = "shared_preload_libraries"
    value        = "pg_stat_statements,pg_cron"
    apply_method = "pending-reboot"
  }

  parameter {
    name         = "cron.database_name"
    value        = var.rds_database_name
    apply_method = "pending-reboot"
  }

  parameter {
    name  = "rds.force_ssl"
    value = "1"
  }

  tags = var.tags
}

resource "aws_rds_cluster" "aurora_cluster" {

  cluster_identifier              = "${var.environment_name}-aurora-cluster"
  database_name                   = var.rds_database_name
  engine                          = var.rds_engine
  engine_version                  = var.rds_engine_version
  master_username                 = var.rds_master_username
  master_password                 = aws_ssm_parameter.db_password.value
  backup_retention_period         = (lower(var.tags["is-production"]) == "true") ? 35 : 14
  preferred_backup_window         = "02:00-03:00"
  preferred_maintenance_window    = "sun:03:00-sun:04:00"
  db_subnet_group_name            = aws_db_subnet_group.aurora_subnet_group.name
  final_snapshot_identifier       = "${var.environment_name}-aurora-cluster-${random_uuid.db_snapshot_id.result}-final"
  vpc_security_group_ids          = [data.aws_security_group.db.id]
  db_cluster_parameter_group_name = aws_rds_cluster_parameter_group.default.name
  enabled_cloudwatch_logs_exports = ["postgresql"]
  apply_immediately               = (lookup(var.tags, "is-production", false) == false) ? true : false
  deletion_protection             = (lookup(var.tags, "is-production", false) == false) ? true : false

  kms_key_id        = aws_kms_key.aurora_cluster_encryption_key.arn
  storage_encrypted = true

  lifecycle {
    create_before_destroy = true
  }

  tags = var.tags
}

resource "aws_rds_cluster_instance" "aurora_cluster_instance" {

  count = length(var.private_subnet_ids)

  identifier           = "${var.environment_name}-aurora-instance-${count.index}"
  cluster_identifier   = aws_rds_cluster.aurora_cluster.id
  engine               = var.rds_engine
  engine_version       = var.rds_engine_version
  instance_class       = var.db_instance_class
  db_subnet_group_name = aws_db_subnet_group.aurora_subnet_group.name
  publicly_accessible  = false
  apply_immediately    = (lookup(var.tags, "is-production", false) == false) ? true : false

  performance_insights_enabled          = true
  performance_insights_kms_key_id       = aws_kms_key.aurora_cluster_encryption_key.arn
  performance_insights_retention_period = (lower(var.tags["is-production"]) == "true") ? 731 : 7

  lifecycle {
    create_before_destroy = true
  }

  tags = var.tags
}

resource "aws_db_subnet_group" "aurora_subnet_group" {

  name        = "${var.environment_name}_aurora_db_subnet_group"
  description = "Allowed subnets for Aurora DB cluster instances"
  subnet_ids  = var.private_subnet_ids

  tags = var.tags
}

resource "aws_route53_record" "db" {
  name    = "db.${data.aws_route53_zone.cjse_dot_org.name}"
  type    = "CNAME"
  zone_id = var.private_zone_id
  ttl     = 30

  records = [
    aws_rds_cluster.aurora_cluster.endpoint
  ]
}
