data "aws_caller_identity" "current" {}

data "aws_region" "current" {}

data "aws_route53_zone" "public" {
  zone_id = var.public_zone_id
}

data "aws_security_group" "user_service_container" {
  name = "${var.name}-user-service-ecs"
}

### These 4 parameters need to be created in SSM before we run the build, they are not automated yet
data "aws_ssm_parameter" "cjse_client_certificate" {
  name = "/${var.name}/smtp/client_cert"
}

data "aws_ssm_parameter" "cjse_root_certificate" {
  name = "/${var.name}/smtp/cjse_root_cert"
}

data "aws_ssm_parameter" "cjse_relay_user" {
  name = "/${var.name}/smtp/relay_user"
}

data "aws_ssm_parameter" "cjse_relay_password" {
  name = "/${var.name}/smtp/relay_password"
}

### End params

### Postfix Cluster
data "template_file" "postfix_ecs_task" {
  template = file("${path.module}/templates/postfix_task.json.tpl")

  vars = {
    postfix_image = "${var.postfix_ecs.repository_url}@${var.postfix_ecs.image_hash}"
    cpu_units     = 1024
    memory_units  = 4096
    mail_hostname = aws_route53_record.mail.fqdn
    mail_domain   = data.aws_route53_zone.public.name
    allowed_cidrs = join(" ", var.application_cidr)
    postfix_cidrs = join(" ", module.postfix_vpc.private_subnets_cidr_blocks)
    cjsm_hostname = local.cjsm_mail_server_dns

    postfix_relay_user_arn       = data.aws_ssm_parameter.cjse_relay_user.arn
    postfix_relay_password_arn   = data.aws_ssm_parameter.cjse_relay_password.arn
    postfix_certificate_arn      = data.aws_ssm_parameter.cjse_client_certificate.arn
    postfix_key_arn              = aws_ssm_parameter.public_domain_signing_key.arn
    postfix_root_certificate_arn = data.aws_ssm_parameter.cjse_root_certificate.arn

    log_group         = aws_cloudwatch_log_group.postfix_log_group.name
    region            = data.aws_region.current.name
    log_stream_prefix = "postfix-ecs"
  }
}

data "template_file" "allow_kms" {
  template = file("${path.module}/policies/allow_kms.json.tpl")

  vars = {
    account_id = data.aws_caller_identity.current.account_id
    region     = data.aws_region.current.name
  }
}
