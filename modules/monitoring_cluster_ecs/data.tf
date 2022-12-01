data "aws_region" "current" {}

data "aws_caller_identity" "current" {}

data "aws_availability_zones" "current" {
  state = "available"
}

data "aws_route53_zone" "cjse_dot_org" {
  zone_id = var.private_zone_id
}

data "template_file" "allow_ecr_policy" {
  template = file("${path.module}/policies/allow_ecr.json.tpl")

  vars = {
    ecr_repos = jsonencode(
      [
        "arn:aws:ecr:${data.aws_region.current.name}:${local.ecr_account_id}:repository/prometheus",
        "arn:aws:ecr:${data.aws_region.current.name}:${local.ecr_account_id}:repository/logstash",
        "arn:aws:ecr:${data.aws_region.current.name}:${local.ecr_account_id}:repository/prometheus-cloudwatch-exporter",
        "arn:aws:ecr:${data.aws_region.current.name}:${local.ecr_account_id}:repository/prometheus-blackbox-exporter",
        "arn:aws:ecr:${data.aws_region.current.name}:${local.ecr_account_id}:repository/grafana"
      ]
    )
  }
}

data "template_file" "allow_kms_access" {
  template = file("${path.module}/policies/allow_kms.json.tpl")

  vars = {
    account_id = data.aws_caller_identity.current.account_id
  }
}

data "template_file" "allow_sns_publish_policy" {
  template = file("${path.module}/policies/allow_sns_policy.json.tpl")

  vars = {
    account_id    = data.aws_caller_identity.current.account_id
    sns_topic_arn = aws_sns_topic.alert_notifications.arn
  }
}

### Iam
data "template_file" "allow_ssm_policy" {
  template = file("${path.module}/policies/allow_ssm.json.tpl")

  vars = {
    ssm_parameter_arns = jsonencode([
      var.admin_htaccess_password_arn,
      aws_ssm_parameter.grafana_db_password.arn,
      aws_ssm_parameter.grafana_admin_password.arn,
      aws_ssm_parameter.grafana_secret_key.arn,
      var.os_username_arn
      ]
    )
  }
}

data "aws_iam_role" "admin_role" {
  name = "Bichard7-Administrator-Access"
}

data "template_file" "allow_ssm_messages" {
  template = file("${path.module}/policies/allow_ssm_messages.json.tpl")

  vars = {
    region              = data.aws_region.current.name
    account             = data.aws_caller_identity.current.account_id
    log_group_name      = var.prometheus_log_group.name
    logging_bucket_name = var.logging_bucket_name
    key_arn             = aws_kms_key.cluster_logs_encryption_key.arn
  }
}

data "aws_lb_target_group" "app" {
  arn = var.app_targetgroup_arn
}

data "aws_lb_target_group" "user_service" {
  arn = var.user_service_targetgroup_arn
}

data "aws_lb" "user_service" {
  name = trim(substr("cjse-${var.tags["Environment"]}-bichard-7-user-service", 0, 32), "-")
}

data "aws_lb" "beanconnect" {
  name = trim(substr("cjse-${var.tags["Environment"]}-bichard-7-beanconnect", 0, 32), "-")
}

data "aws_lb_target_group" "beanconnect" {
  arn = var.beanconnect_targetgroup_arn
}

data "template_file" "grafana_ecs_task" {
  template = file("${path.module}/templates/grafana.json.tpl")

  vars = {
    grafana_image      = var.grafana_image
    region             = data.aws_region.current.name
    application_cpu    = var.fargate_cpu
    application_memory = var.fargate_memory
    log_group          = data.aws_cloudwatch_log_group.grafana.name

    exporter_log_stream_prefix = "grafana"

    ## Grafana Config for Env Vars
    grafana_domain             = local.grafana_domain
    database_type              = "postgres"
    database_host              = aws_rds_cluster.grafana_db.endpoint
    database_name              = aws_rds_cluster.grafana_db.database_name
    database_user              = aws_ssm_parameter.grafana_db_username.value
    database_password_arn      = aws_ssm_parameter.grafana_db_password.arn
    grafana_admin              = aws_ssm_parameter.grafana_admin_username.value
    grafana_admin_password_arn = aws_ssm_parameter.grafana_admin_password.arn
    grafana_secret_key_arn     = aws_ssm_parameter.grafana_secret_key.arn

    # Prometheus Datasource Config
    prometheus_url          = "https://${aws_route53_record.prometheus_public_record.fqdn}"
    prometheus_user         = var.admin_htaccess_username
    prometheus_password_arn = var.admin_htaccess_password_arn
    alertmanager_url        = "https://${aws_route53_record.prometheus_alert_manager_public_record.fqdn}"
    domain                  = var.public_zone_name

    # Grafana Dashboard Config
    environment     = var.tags["Environment"]
    target_group    = data.aws_lb_target_group.app.arn_suffix
    userservice_alb = data.aws_lb.user_service.arn_suffix
    prometheus_alb  = aws_alb.prometheus_alb.arn_suffix
    grafana_alb     = aws_alb.grafana_alb.arn_suffix
    cloudwatch_alb  = aws_alb.prometheus_cloudwatch_exporter_alb.arn_suffix
    beanconnect_nlb = data.aws_lb_target_group.beanconnect.arn_suffix
  }
}

### Python Lambda
data "template_file" "alert_webhook_source" {
  template = file("${path.module}/sources/alert.py.tpl")

  vars = {
    environment       = var.tags["Environment"]
    webhook_url       = var.slack_webhook_url
    channel_name      = var.slack_channel_name
    alertmanager_fqdn = aws_route53_record.prometheus_alert_manager_public_record.fqdn

  }
}

data "aws_secretsmanager_secret" "os_password" {
  name = "cjse-${terraform.workspace}-bichard-7-opensearch-password"
}

data "aws_secretsmanager_secret_version" "os_password" {
  secret_id = data.aws_secretsmanager_secret.os_password.id
}

data "aws_kms_key" "secret_encryption_key" {
  key_id = "alias/cjse-${terraform.workspace}-bichard-7-os-secret"
}

## Log groups

data "aws_cloudwatch_log_group" "grafana" {
  name = "cjse-bichard7-${var.tags["Environment"]}-base-infra-grafana"
}

data "template_file" "allow_cmk_admin_access" {
  template = file("${path.module}/policies/allow_cmk_admin_access.json.tpl")

  vars = {
    kms_key_arn = aws_kms_key.cluster_logs_encryption_key.arn
  }
}

data "template_file" "allow_sns_events_publish" {
  template = file("${path.module}/policies/allow_sns_events_publish.json.tpl")

  vars = {
    sns_topic_arn = aws_sns_topic.alert_notifications.arn
  }
}

data "template_file" "allow_notifications_kms_access" {
  template = file("${path.module}/policies/allow_notifications_kms_access.json.tpl")

  vars = {
    kms_key_arn = aws_kms_key.alert_notifications_key.arn
  }
}

### Alerts Lambda
data "archive_file" "alert_archive" {
  output_path = "/tmp/alert_notification.zip"
  type        = "zip"

  source {
    content  = data.template_file.alert_webhook_source.rendered
    filename = "alert.py"
  }
}
