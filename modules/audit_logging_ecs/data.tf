data "aws_caller_identity" "current" {}

data "aws_region" "current" {}

data "template_file" "audit_logging_portal_fargate" {
  template = file("${path.module}/templates/audit_logging_portal_task.json.tpl")

  vars = {
    audit_logging_image = "${var.audit_logging_portal_ecs_image_url}@${aws_ssm_parameter.audit_logging_deploy_tag.value}"
    cpu_units           = local.portal_cpu_units
    memory_units        = local.portal_memory_units
    log_group           = var.audit_logging_portal_log_group.name
    log_stream_prefix   = "bichard-audit-logging-portal"
    region              = data.aws_region.current.name
    api_url             = var.api_url
    config_cpu_units    = local.config_cpu_units
    config_memory_units = local.config_memory_units
    config_volume       = "data"
    api_key_arn         = var.audit_log_api_key_arn
  }
}

data "aws_route53_zone" "public_zone" {
  zone_id = var.public_zone_id
}

data "aws_security_group" "audit_logging_portal" {
  name = "${var.name}-portal-ecs"
}

data "aws_security_group" "audit_logging_portal_alb" {
  name = "${var.name}-portal-alb"
}
