data "aws_region" "current" {}

data "aws_caller_identity" "current" {}

data "aws_availability_zones" "current" {
  state = "available"
}

data "aws_route53_zone" "cjse_dot_org" {
  zone_id = var.private_zone_id
}

### Iam
data "template_file" "allow_ssm" {
  template = file("${path.module}/policies/allow_ssm.json.tpl")

  vars = {
    ssm_parameter_arns = jsonencode([
      aws_ssm_parameter.admin_htaccess_password.arn,
      aws_ssm_parameter.grafana_db_password.arn,
      aws_ssm_parameter.grafana_admin_password.arn,
      aws_ssm_parameter.grafana_secret_key.arn,
      data.aws_ssm_parameter.es_password.arn,
      data.aws_ssm_parameter.es_username.arn
      ]
    )
  }
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

### Prometheus exporter
data "template_file" "prometheus_exporter_ecs_task" {
  template = file("${path.module}/templates/prometheus_exporter.task.json.tpl")

  vars = {
    prometheus_cloudwatch_exporter_image = var.prometheus_cloudwatch_exporter_image
    region                               = data.aws_region.current.name
    application_cpu                      = var.fargate_cpu
    application_memory                   = var.fargate_memory
    log_group                            = data.aws_cloudwatch_log_group.cloudwatch_exporter.name
    exporter_log_stream_prefix           = "prometheus-cloudwatch-exporter"
  }
}

### Prometheus Blackbox exporter
data "template_file" "prometheus_blackbox_exporter_ecs_task" {
  template = file("${path.module}/templates/prometheus_blackbox_exporter.json.tpl")

  vars = {
    prometheus_blackbox_exporter_image  = var.prometheus_blackbox_exporter_image
    region                              = data.aws_region.current.name
    application_cpu                     = var.fargate_cpu
    application_memory                  = var.fargate_memory
    log_group                           = data.aws_cloudwatch_log_group.blackbox_exporter.name
    blackbox_exporter_log_stream_prefix = "prometheus-blackbox-exporter"
  }
}

### Prometheus
data "template_file" "prometheus_ecs_task" {
  template = file("${path.module}/templates/prometheus.task.json.tpl")

  vars = {
    prometheus_image   = var.prometheus_image
    region             = data.aws_region.current.name
    application_cpu    = var.fargate_cpu
    application_memory = var.fargate_memory
    data_volume        = "${var.name}-prometheus-data"
    data_mount_dir     = local.prometheus_data_dir
    retention_days     = var.prometheus_data_retention_days
    log_group          = var.prometheus_log_group.name
    htpasswd_arn       = aws_ssm_parameter.admin_htaccess_password.arn
    sns_arn            = replace(aws_sns_topic.alert_notifications.arn, aws_sns_topic.alert_notifications.name, "")

    cloudwatch_exporter_url    = aws_route53_record.prometheus_cloudwatch_exporter_private_dns.fqdn
    blackbox_exporter_url      = aws_route53_record.prometheus_blackbox_exporter_private_dns.fqdn
    pnc_port                   = local.pnc_port
    sns_exporter_url           = "localhost"
    sns_topic_name             = aws_sns_topic.alert_notifications.name
    data_retention_days        = var.prometheus_data_retention_days
    exporter_log_stream_prefix = "prometheus"
    public_zone_name           = var.public_zone_name
    use_smtp_server            = var.using_smtp_service
  }
}

### Grafana
data "aws_lb_target_group" "app" {
  arn = var.app_targetgroup_arn
}

data "aws_lb_target_group" "user_service" {
  arn = var.user_service_targetgroup_arn
}

data "aws_lb" "user_service" {
  name = trim(substr("cjse-${var.tags["Environment"]}-bichard-7-user-service", 0, 32), "-")
}

data "aws_lb_target_group" "audit_logging" {
  arn = var.audit_logging_targetgroup_arn
}

data "aws_lb" "beanconnect" {
  name = trim(substr("cjse-${var.tags["Environment"]}-bichard-7-beanconnect", 0, 32), "-")
}

data "aws_lb_target_group" "beanconnect" {
  arn = var.beanconnect_targetgroup_arn
}

data "aws_lb" "audit_logging" {
  name = trim(substr("cjse-${var.tags["Environment"]}-bichard-7-audit-portal", 0, 32), "-")
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
    prometheus_user         = aws_ssm_parameter.admin_htaccess_username.value
    prometheus_password_arn = aws_ssm_parameter.admin_htaccess_password.arn
    alertmanager_url        = "https://${aws_route53_record.prometheus_alert_manager_public_record.fqdn}"
    domain                  = var.public_zone_name

    # Grafana Dashboard Config
    environment     = var.tags["Environment"]
    target_group    = data.aws_lb_target_group.app.arn_suffix
    userservice_alb = data.aws_lb.user_service.arn_suffix
    prometheus_alb  = aws_alb.prometheus_alb.arn_suffix
    grafana_alb     = aws_alb.grafana_alb.arn_suffix
    cloudwatch_alb  = aws_alb.prometheus_cloudwatch_exporter_alb.arn_suffix
    audit_alb       = data.aws_lb.audit_logging.arn_suffix
    beanconnect_nlb = data.aws_lb_target_group.beanconnect.arn_suffix
  }
}

### Security groups
data "aws_security_group" "prometheus_exporter_security_group" {
  name = "${var.name}-prometheus-cloudwatch-exporter"
}

data "aws_security_group" "prometheus_cloudwatch_exporter_alb" {
  name = "${var.name}-prometheus-cloudwatch-exporter-alb"
}

data "aws_security_group" "prometheus_blackbox_exporter_security_group" {
  name = "${var.name}-prometheus-blackbox-exporter"
}

data "aws_security_group" "prometheus_blackbox_exporter_alb" {
  name = "${var.name}-prometheus-blackbox-exporter-alb"
}

data "aws_security_group" "prometheus_security_group" {
  name = "${var.name}-prometheus"
}

data "aws_security_group" "prometheus_alb" {
  name = "${var.name}-prometheus-alb"
}

data "aws_security_group" "prometheus_alert_manager_alb" {
  name = "${var.name}-prometheus-alert-manager-alb"
}

data "aws_security_group" "grafana_security_group" {
  name = "${var.name}-grafana"
}

data "aws_security_group" "grafana_alb_security_group" {
  name = "${var.name}-grafana-alb"
}

data "aws_security_group" "grafana_db_security_group" {
  name = "${var.name}-grafana-db"
}

data "aws_security_group" "logstash_security_group" {
  name = "${var.name}-logstash"
}

data "aws_security_group" "logstash_alb_security_group" {
  name = "${var.name}-logstash-alb"
}

data "aws_security_group" "elasticsearch_security_group" {
  name = "${var.name}-elasticsearch"
}

data "aws_security_group" "user_service_alb" {
  name = "${var.name}-user-service-alb"
}

data "aws_security_group" "bichard_alb_web" {
  name = "${var.name}-alb-web"
}

data "aws_security_group" "bichard7_alb_backend" {
  name = "${var.name}-alb-backend"
}

data "aws_security_group" "audit_logging_portal_alb" {
  name = "${var.name}-portal-alb"
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

### Logstash
data "aws_ssm_parameter" "es_username" {
  name            = "/cjse-${var.tags["Environment"]}-bichard-7/es/master/username"
  with_decryption = true
}

data "aws_ssm_parameter" "es_password" {
  name = "/cjse-${var.tags["Environment"]}-bichard-7/es/master/password"
}

data "template_file" "logstash" {
  template = file("${path.module}/templates/logstash.json.tpl")

  vars = {
    logstash_image     = var.logstash_image
    application_cpu    = var.fargate_cpu
    application_memory = var.fargate_memory
    elasticsearch_host = var.elasticsearch_host
    es_username        = data.aws_ssm_parameter.es_username.value
    environment        = var.tags["Environment"]
    log_level          = "debug"
    es_password_arn    = data.aws_ssm_parameter.es_password.arn

    log_group                  = data.aws_cloudwatch_log_group.logstash.name
    exporter_log_stream_prefix = "logstash"
    region                     = data.aws_region.current.name
  }
}

## Log groups
data "aws_cloudwatch_log_group" "logstash" {
  name = "cjse-bichard7-${var.tags["Environment"]}-base-infra-logstash"
}

data "aws_cloudwatch_log_group" "grafana" {
  name = "cjse-bichard7-${var.tags["Environment"]}-base-infra-grafana"
}

data "aws_cloudwatch_log_group" "cloudwatch_exporter" {
  name = "cjse-bichard7-${var.tags["Environment"]}-base-infra-cloudwatch-exporter"
}

data "aws_cloudwatch_log_group" "blackbox_exporter" {
  name = "cjse-bichard7-${var.tags["Environment"]}-base-infra-blackbox-exporter"
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
