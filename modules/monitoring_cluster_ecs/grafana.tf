## This entire comment block will be needed later when we set grafana up to use the db

resource "random_string" "grafana_admin_suffix" {
  special = false
  length  = 12
}

resource "random_string" "grafana_dbuser" {
  special = false
  number  = false
  length  = 24
}

resource "random_password" "grafana_admin_password" {
  length  = 24
  special = false
}

resource "random_string" "grafana_secret_key" {
  length  = 24
  special = false
}

resource "random_password" "grafana_db_password" {
  length  = 24
  special = false
}

resource "aws_ssm_parameter" "grafana_admin_username" {
  name      = "/${var.name}/monitoring/grafana/username"
  type      = "SecureString"
  value     = "grafana_${random_string.grafana_admin_suffix.result}"
  overwrite = true

  tags = var.tags
}

resource "aws_ssm_parameter" "grafana_admin_password" {
  name      = "/${var.name}/monitoring/grafana/password"
  type      = "SecureString"
  value     = random_password.grafana_admin_password.result
  overwrite = true

  tags = var.tags
}

resource "aws_ssm_parameter" "grafana_db_username" {
  name      = "/${var.name}/monitoring/grafana/db_username"
  type      = "SecureString"
  value     = random_string.grafana_dbuser.result
  overwrite = true

  tags = var.tags
}

resource "aws_ssm_parameter" "grafana_db_password" {
  name      = "/${var.name}/monitoring/grafana/db_password"
  type      = "SecureString"
  value     = random_password.grafana_db_password.result
  overwrite = true

  tags = var.tags
}

resource "aws_ssm_parameter" "grafana_secret_key" {
  name      = "/${var.name}/monitoring/grafana/secret"
  type      = "SecureString"
  value     = random_string.grafana_secret_key.result
  overwrite = true

  tags = var.tags
}

resource "aws_db_subnet_group" "grafana_subnet_group" {
  name        = "${var.name}_grafana_db_subnet_group"
  description = "Allowed subnets for Grafana DB instance"
  subnet_ids  = var.service_subnets

  tags = var.tags
}

resource "aws_kms_key" "aurora_cluster_encryption_key" {
  description             = "${var.name}-grafana-db-key"
  deletion_window_in_days = 10
  enable_key_rotation     = true

  tags = var.tags
}

resource "aws_kms_alias" "aurora_cluster_encryption_key_alias" {
  target_key_id = aws_kms_key.aurora_cluster_encryption_key.id
  name          = "alias/${var.name}-grafana-db-cluster"
}

resource "aws_rds_cluster" "grafana_db" {
  cluster_identifier = "${var.name}-grafana"

  enable_global_write_forwarding = false

  engine         = "aurora-postgresql"
  engine_version = "13.4"

  availability_zones = data.aws_availability_zones.current.names
  vpc_security_group_ids = [
    data.aws_security_group.grafana_db_security_group.id
  ]

  database_name   = "grafana"
  master_username = aws_ssm_parameter.grafana_db_username.value
  master_password = aws_ssm_parameter.grafana_db_password.value

  backup_retention_period   = (lower(var.tags["is-production"]) == "true") ? 35 : 14
  preferred_backup_window   = "23:30-00:00"
  copy_tags_to_snapshot     = true
  final_snapshot_identifier = "${var.name}-grafana-final-${random_string.grafana_admin_suffix.result}"

  enabled_cloudwatch_logs_exports = ["postgresql"]

  deletion_protection = (lower(var.tags["is-production"]) == "true") ? true : false

  apply_immediately            = (lower(var.tags["is-production"]) == "true") ? false : true
  preferred_maintenance_window = "wed:04:00-wed:04:30"

  storage_encrypted    = true
  kms_key_id           = aws_kms_key.aurora_cluster_encryption_key.arn
  db_subnet_group_name = aws_db_subnet_group.grafana_subnet_group.name

  tags = var.tags
}

# tfsec:ignore:aws-rds-enable-performance-insights
resource "aws_rds_cluster_instance" "grafana_db_instance" {
  count = 3

  cluster_identifier   = aws_rds_cluster.grafana_db.id
  instance_class       = var.grafana_db_instance_class
  engine               = aws_rds_cluster.grafana_db.engine
  engine_version       = aws_rds_cluster.grafana_db.engine_version
  db_subnet_group_name = aws_db_subnet_group.grafana_subnet_group.name

  auto_minor_version_upgrade   = true
  preferred_maintenance_window = aws_rds_cluster.grafana_db.preferred_maintenance_window

  tags = var.tags
}

resource "aws_ecs_task_definition" "grafana_ecs_task" {
  family             = "${var.name}-grafana"
  execution_role_arn = aws_iam_role.prometheus_task_role.arn

  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  memory                   = var.fargate_memory
  cpu                      = var.fargate_cpu

  task_role_arn         = aws_iam_role.prometheus_task_role.arn
  container_definitions = data.template_file.grafana_ecs_task.rendered

  tags = var.tags
}

resource "aws_ecs_service" "grafana_ecs_service" {
  name            = "${var.name}-grafana"
  cluster         = aws_ecs_cluster.monitoring_cluster.id
  task_definition = aws_ecs_task_definition.grafana_ecs_task.arn
  desired_count   = 1
  launch_type     = "FARGATE"

  enable_execute_command = var.remote_exec_enabled

  network_configuration {
    security_groups = [
      data.aws_security_group.grafana_security_group.id
    ]
    subnets = var.service_subnets
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.grafana_alb_target_group.id
    container_name   = "grafana"
    container_port   = 3000
  }
  depends_on = [aws_lb_listener.grafana_https_listener]

  tags = var.tags
}

resource "aws_alb" "grafana_alb" {
  name = local.grafana_alb_name

  subnets = var.service_subnets

  security_groups = [
    data.aws_security_group.grafana_alb_security_group.id
  ]
  internal = true

  access_logs {
    bucket  = var.logging_bucket_name
    enabled = true
    prefix  = "alb/AWSLogs/${data.aws_caller_identity.current.account_id}/${local.grafana_alb_name}"
  }

  enable_deletion_protection = (lower(var.tags["is-production"]) == "true") ? true : false
  drop_invalid_header_fields = true

  tags = var.tags
}

resource "aws_lb_target_group" "grafana_alb_target_group" {
  name_prefix = local.grafana_alb_name_prefix
  port        = 3000
  protocol    = "HTTPS"
  vpc_id      = var.vpc_id
  target_type = "ip"

  health_check {
    healthy_threshold   = "3"
    port                = 3000
    interval            = "30"
    protocol            = "HTTPS"
    matcher             = "200"
    timeout             = "3"
    path                = "/api/health"
    unhealthy_threshold = "10"
  }

  tags = var.tags
}

resource "aws_lb_listener" "grafana_https_listener" {
  load_balancer_arn = aws_alb.grafana_alb.arn
  port              = 443
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-TLS-1-2-Ext-2018-06"
  certificate_arn   = var.ssl_certificate_arn

  default_action {
    target_group_arn = aws_lb_target_group.grafana_alb_target_group.arn
    type             = "forward"
  }
}

resource "aws_lb_listener" "grafana_http_listener" {
  load_balancer_arn = aws_alb.grafana_alb.arn
  port              = 80
  protocol          = "HTTP" #tfsec:ignore:AWS004

  default_action {
    type = "redirect"

    redirect {
      port        = "443"
      protocol    = "HTTPS"
      status_code = "HTTP_301"
    }
  }
}

resource "aws_route53_record" "db_internal" {
  name    = "grafanadb.${data.aws_route53_zone.cjse_dot_org.name}"
  type    = "CNAME"
  zone_id = data.aws_route53_zone.cjse_dot_org.zone_id
  ttl     = 30
  records = [aws_rds_cluster.grafana_db.endpoint]
}

resource "aws_route53_record" "grafana_public_record" {
  name    = "grafana.${var.public_zone_name}"
  type    = "CNAME"
  zone_id = var.public_zone_id
  ttl     = 30
  records = [aws_alb.grafana_alb.dns_name]
}
