data "aws_region" "current" {}

data "aws_route53_zone" "public_zone" {
  zone_id = var.public_zone_id
}

data "aws_security_group" "user_service_alb" {
  name = "${var.name}-user-service-alb"
}

data "aws_security_group" "user_service_ecs" {
  name = "${var.name}-user-service-ecs"
}

data "template_file" "user_service_fargate" {
  template = file("${path.module}/templates/user_service_task.json.tpl")

  vars = {
    user_service_image        = "${var.user_service_ecs_image_url}@${aws_ssm_parameter.user_service_deploy_tag.value}"
    user_service_cpu_units    = var.fargate_cpu
    user_service_memory_units = var.fargate_memory
    log_group                 = var.user_service_log_group.name
    log_stream_prefix         = "bichard-user-service"
    region                    = data.aws_region.current.name
    base_url                  = "https://proxy.${data.aws_route53_zone.public_zone.name}/users"
    bichard_redirect_url      = "/bichard-ui/Authenticate"
    audit_logging_url         = "audit-logging"
    db_host                   = var.db_host
    db_ssl                    = var.db_ssl
    db_user                   = "bichard"
    db_password_arn           = var.db_password_arn
    incorrect_delay           = var.incorrect_delay
    hide_non_prod_banner      = var.hide_non_prod_banner
    token_expires_in          = var.token_expires_in
    email_from                = var.email_from_address
    smtp_host                 = var.smtp_host
    smtp_user                 = var.smtp_user
    smtp_password             = var.smtp_password
    smtp_tls                  = var.smtp_tls
    smtp_port                 = var.smtp_port
    jwt_secret_arn            = var.jwt_secret_arn
    cookie_secret_arn         = var.cookie_secret_arn
    csrf_cookie_secret_arn    = var.csrf_cookie_secret_arn
    csrf_form_secret_arn      = var.crsf_form_secret_arn
    cookies_secure            = var.cookies_secure

  }
}
