data "aws_region" "current" {}

data "aws_caller_identity" "current" {}

data "aws_route53_zone" "public_zone" {
  zone_id = var.public_zone_id
}

### Security Groups
data "aws_security_group" "nginx_auth_proxy_alb" {
  name = "${var.name}-nginx-auth-proxy-alb"
}

data "aws_security_group" "nginx_auth_proxy_ecs" {
  name = "${var.name}-nginx-auth-proxy-ecs"
}

data "aws_security_group" "user_service_alb" {
  name = "${var.name}-user-service-alb"
}

data "aws_security_group" "bichard_alb" {
  name = "${var.name}-alb-web"
}

data "aws_security_group" "bichard_backend_alb" {
  name = "${var.name}-alb-backend"
}

data "aws_security_group" "audit_logging_portal_alb" {
  name = "${var.name}-portal-alb"
}

data "aws_security_group" "ui_alb" {
  name = "${var.name}-ui-alb"
}

### Templates
data "template_file" "nginx_auth_proxy_fargate" {
  template = file("${path.module}/templates/nginx_auth_proxy_task.json.tpl")

  vars = {
    nginx_auth_proxy_image        = "${var.nginx_auth_proxy_ecs_image_url}@${aws_ssm_parameter.nginx_auth_proxy_deploy_tag.value}"
    nginx_auth_proxy_cpu_units    = var.fargate_cpu
    nginx_auth_proxy_memory_units = var.fargate_memory
    log_group                     = var.nginx_auth_proxy_log_group.name
    log_stream_prefix             = "bichard-nginx-auth-proxy"
    region                        = data.aws_region.current.name
    dns_resolver                  = var.dns_resolver
    user_service_domain           = "users.${data.aws_route53_zone.public_zone.name}"
    ui_domain                     = "ui.${data.aws_route53_zone.public_zone.name}"
    audit_logging_domain          = "audit.${data.aws_route53_zone.public_zone.name}"
    bichard_domain                = "bichard-web.${data.aws_route53_zone.public_zone.name}"
    bichard_backend_domain        = "bichard-backend.${data.aws_route53_zone.public_zone.name}"
    static_service_domain         = "static-files.${data.aws_route53_zone.public_zone.name}"
  }
}
