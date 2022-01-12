data "aws_caller_identity" "current" {}

data "aws_region" "current" {}

data "aws_ami" "amazon_linux_2" {
  most_recent = true

  owners = [
    "amazon"
  ]

  filter {
    name   = "name"
    values = ["*amzn2-ami-hvm*"]
  }
  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

data "aws_route53_zone" "public" {
  zone_id = var.public_zone_id
}

data "aws_security_group" "user_service_container" {
  name = "${var.name}-user-service-ecs"
}

data "template_file" "postfix_ansible_playbook" {
  template = file("${path.module}/templates/playbook.yml.tpl")

  vars = {
    postfix_fqdn          = local.postfix_fqdn
    fqdn                  = data.aws_route53_zone.public.name
    postfix_ip_1          = aws_eip.postfix_static_ip[0].private_ip
    postfix_ip_2          = aws_eip.postfix_static_ip[1].private_ip
    postfix_ip_3          = aws_eip.postfix_static_ip[2].private_ip
    allowed_cidr          = join(" ", var.ingress_cidr_blocks)
    postfix_cidr          = join(" ", module.postfix_vpc.private_subnets_cidr_blocks)
    cjse_mail_host        = local.cjsm_mail_server_dns
    root_certificate      = data.aws_ssm_parameter.cjse_root_certificate.name
    client_certificate    = data.aws_ssm_parameter.cjse_client_certificate.name
    client_key            = aws_ssm_parameter.public_domain_signing_key.name
    relay_user            = data.aws_ssm_parameter.cjse_relay_user.name
    relay_password        = data.aws_ssm_parameter.cjse_relay_password.name
    sasl_user             = aws_ssm_parameter.postfix_remote_user.value
    remote_user           = aws_ssm_parameter.postfix_remote_user.name
    remote_password       = aws_ssm_parameter.postfix_remote_password.name
    domain_name           = data.aws_route53_zone.public.name
    self_signed_cert      = module.smtp_nginx_self_signed_certificate.server_certificate.ssm_certificate_path
    self_signed_cert_key  = module.smtp_nginx_self_signed_certificate.server_certificate.ssm_key_path
    ssm_cloudwatch_config = aws_ssm_parameter.cloudwatch_agent_configuration_file.name
  }
}

data "template_file" "postfix_instance_userdata" {
  template = file("${path.module}/scripts/user_data.sh.tpl")

  vars = {
    ansible_playbook = base64encode(data.template_file.postfix_ansible_playbook.rendered)
  }
}

data "template_file" "bastion_instance_userdata" {
  template = file("${path.module}/scripts/bastion_user_data.sh.tpl")

  vars = {
    ssm_ssh_key_name = aws_ssm_parameter.private_key.name
    postfix_ip_1     = aws_eip.postfix_static_ip[0].private_ip
    postfix_ip_2     = aws_eip.postfix_static_ip[1].private_ip
    postfix_ip_3     = aws_eip.postfix_static_ip[2].private_ip
  }
}

data "template_file" "bastion_allow_ssm_parameters" {
  template = file("${path.module}/policies/allow_ssm.json.tpl")

  vars = {
    ssm_parameter_arns = jsonencode(
      [
        aws_ssm_parameter.private_key.arn
      ]
    )
  }
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

data "template_file" "postfix_allow_ssm_parameters" {
  template = file("${path.module}/policies/allow_ssm.json.tpl")

  vars = {
    ssm_parameter_arns = jsonencode([
      data.aws_ssm_parameter.cjse_client_certificate.arn,
      data.aws_ssm_parameter.cjse_root_certificate.arn,
      aws_ssm_parameter.public_domain_signing_key.arn,
      data.aws_ssm_parameter.cjse_relay_user.arn,
      data.aws_ssm_parameter.cjse_relay_password.arn,
      aws_ssm_parameter.postfix_remote_password.arn,
      aws_ssm_parameter.postfix_remote_user.arn,
      module.smtp_nginx_self_signed_certificate.server_certificate.ssm_certificate_arn,
      module.smtp_nginx_self_signed_certificate.server_certificate.ssm_key_arn,
      aws_ssm_parameter.cloudwatch_agent_configuration_file.arn
    ])
  }
}

data "template_file" "bastion_cloudwatch_agent" {
  template = file("${path.module}/templates/cloudwatch_agent_config.json.tpl")

  vars = {
    service_name = var.name
    environment  = var.tags["workspace"]
  }
}

### Postfix Cluster
data "template_file" "postfix_ecs_task" {
  template = file("${path.module}/templates/postfix_task.json.tpl")

  vars = {
    postfix_image = "${var.postfix_repository_arn}@${var.postfix_image_hash}"
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
