resource "random_password" "amq" {
  length  = 24
  special = false
}

resource "aws_ssm_parameter" "amq_password" {
  name      = "/${var.environment_name}/mq/password"
  type      = "SecureString"
  value     = random_password.amq.result
  overwrite = true
  tags      = var.tags
}

resource "aws_kms_key" "amq_encryption_key" {
  description             = "${var.environment_name} amq key"
  deletion_window_in_days = 10
  enable_key_rotation     = true

  tags = var.tags
}

resource "aws_kms_alias" "amq" {
  target_key_id = aws_kms_key.amq_encryption_key.id
  name          = "alias/${var.environment_name}-amq"
}

resource "aws_cloudwatch_log_resource_policy" "amazon-mq-log-publishing-policy" {
  policy_document = data.aws_iam_policy_document.amazon_mq_log_publishing_policy.json
  policy_name     = "${var.environment_name}-mq-logging policy"
}

resource "aws_mq_configuration" "amq" {
  description    = "Bichard Amazon MQ Configuration"
  name           = "${var.environment_name}-mq-config"
  engine_type    = "ActiveMQ"
  engine_version = "5.15.0"

  data = file("${path.module}/configuration/amq_config.xml")

  tags = var.tags
}

resource "aws_mq_broker" "amq" {
  broker_name = "${var.environment_name}-amq"

  engine_type         = "ActiveMQ"
  engine_version      = "5.15.14"
  host_instance_type  = var.broker_instance_type
  security_groups     = [data.aws_security_group.amq.id]
  deployment_mode     = "ACTIVE_STANDBY_MULTI_AZ"
  publicly_accessible = false
  subnet_ids          = slice(var.private_subnet_ids, 0, 2)
  apply_immediately   = (lookup(var.tags, "is-production", false) == false) ? true : false

  configuration {
    id       = aws_mq_configuration.amq.id
    revision = aws_mq_configuration.amq.latest_revision
  }

  maintenance_window_start_time {
    day_of_week = "SUNDAY"
    time_of_day = "01:00"
    time_zone   = "UTC"
  }

  encryption_options {
    kms_key_id        = aws_kms_key.amq_encryption_key.arn
    use_aws_owned_key = false
  }

  user {
    username       = var.amq_master_username
    password       = aws_ssm_parameter.amq_password.value
    console_access = true
  }

  logs {
    general = true
    audit   = true
  }

  tags = var.tags
}

resource "aws_route53_record" "mq" {
  name    = "mq.${data.aws_route53_zone.cjse_dot_org.name}"
  type    = "A"
  zone_id = var.private_zone_id
  ttl     = 30

  records = [
    aws_mq_broker.amq.instances[0].ip_address
  ]
}
