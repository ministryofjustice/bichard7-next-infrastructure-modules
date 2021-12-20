data "aws_caller_identity" "current" {}

data "aws_route53_zone" "cjse_dot_org" {
  zone_id = var.private_zone_id
}

data "aws_security_group" "db" {
  name = "${var.environment_name}-aurora"
}

data "aws_security_group" "bichard7_web" {
  name = "${var.environment_name}-web"
}

data "aws_security_group" "bichard7_backend" {
  name = "${var.environment_name}-backend"
}

data "aws_security_group" "user_service_ecs" {
  name = "${var.environment_name}-user-service-ecs"
}
