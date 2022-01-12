resource "tls_private_key" "aws_keypair" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "aws_keypair" {
  public_key = tls_private_key.aws_keypair.public_key_openssh
  key_name   = "${var.name}-ssh-key"

  tags = var.tags
}

resource "aws_ssm_parameter" "private_key" {
  name  = "/${local.env}/postfix/ssh_key"
  type  = "SecureString"
  value = tls_private_key.aws_keypair.private_key_pem

  tags = var.tags
}

resource "aws_network_interface" "static_ip" {
  count = length(module.postfix_vpc.private_subnets)

  subnet_id   = module.postfix_vpc.private_subnets[count.index]
  private_ips = [cidrhost(module.postfix_vpc.private_subnets_cidr_blocks[count.index], 50)]
  security_groups = [
    aws_security_group.postfix_vpc_sg.id,
    aws_security_group.postfix_instance.id,
    aws_security_group.postfix_vpce.id
  ]
}

resource "aws_eip" "postfix_static_ip" {
  count = length(module.postfix_vpc.private_subnets)

  network_interface         = aws_network_interface.static_ip[count.index].id
  associate_with_private_ip = cidrhost(module.postfix_vpc.private_subnets_cidr_blocks[count.index], 50)
  tags                      = var.tags
}

resource "aws_instance" "postfix" {
  count = length(module.postfix_vpc.private_subnets)

  ami           = data.aws_ami.amazon_linux_2.id
  instance_type = "t2.medium"
  monitoring    = true

  user_data = base64encode(data.template_file.postfix_instance_userdata.rendered)

  key_name = aws_key_pair.aws_keypair.key_name

  network_interface {
    device_index         = 0
    network_interface_id = aws_network_interface.static_ip[count.index].id
  }

  root_block_device {
    volume_size           = 32
    encrypted             = true
    delete_on_termination = true
  }

  tags = merge(var.tags,
    {
      Name = "${var.name}-postfix${count.index + 1}"
      FQDN = "mail.${count.index + 1}.${data.aws_route53_zone.public.name}"
    }
  )
  volume_tags = merge(var.tags,
    {
      Name = "${var.name}-postfix${count.index + 1}"
      FQDN = "mail.${count.index + 1}.${data.aws_route53_zone.public.name}"
    }
  )

  metadata_options {
    http_tokens   = "required"
    http_endpoint = "enabled"
  }

  iam_instance_profile = aws_iam_instance_profile.postfix_instance_profile.name

  lifecycle {
    ignore_changes = [
      security_groups
    ]
  }
}

resource "aws_ssm_parameter" "postfix_remote_user" {
  name  = "/${var.name}/smtp/postfix_user"
  type  = "SecureString"
  value = "smtpd.${terraform.workspace}"

  tags = var.tags
}

resource "random_password" "postfix_remote_password" {
  length  = 24
  special = false
}

resource "aws_ssm_parameter" "postfix_remote_password" {
  name  = "/${var.name}/smtp/postfix_password"
  type  = "SecureString"
  value = random_password.postfix_remote_password.result

  tags = var.tags
}

resource "aws_lb" "postfix_nlb" {
  name = "${terraform.workspace}-postfix"

  load_balancer_type = "network"
  ip_address_type    = "ipv4"
  subnets            = module.postfix_vpc.private_subnets
  internal           = true

  enable_deletion_protection = true
  drop_invalid_header_fields = true

  tags = var.tags
}

resource "aws_lb_target_group" "postfix_smtp" {
  name        = "${terraform.workspace}-postfix-smtp"
  port        = 25
  protocol    = "TCP"
  vpc_id      = module.postfix_vpc.vpc_id
  target_type = "instance"

  health_check {
    protocol            = "TCP"
    port                = 9100
    interval            = 10
    healthy_threshold   = 10
    unhealthy_threshold = 10
  }

  tags = var.tags
}

resource "aws_lb_listener" "postfix_smtp" {
  load_balancer_arn = aws_lb.postfix_nlb.arn
  port              = 2525
  protocol          = "TCP"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.postfix_smtp.arn
  }
}

resource "aws_lb_target_group" "postfix_smtps" {
  name        = "${terraform.workspace}-postfix-smtps"
  port        = 465
  protocol    = "TCP"
  vpc_id      = module.postfix_vpc.vpc_id
  target_type = "instance"

  health_check {
    protocol            = "TCP"
    port                = 9100
    interval            = 10
    healthy_threshold   = 10
    unhealthy_threshold = 10
  }

  tags = var.tags
}

resource "aws_lb_listener" "postfix_smtps" {
  load_balancer_arn = aws_lb.postfix_nlb.arn
  port              = 4545
  protocol          = "TCP"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.postfix_smtps.arn
  }
}

resource "aws_lb_target_group" "postfix_prometheus_node_exporter" {
  name        = "${terraform.workspace}-node-exporter"
  port        = 9100
  protocol    = "TCP"
  vpc_id      = module.postfix_vpc.vpc_id
  target_type = "instance"

  health_check {
    protocol            = "TCP"
    port                = 9100
    interval            = 10
    healthy_threshold   = 10
    unhealthy_threshold = 10
  }

  tags = var.tags
}

resource "aws_lb_listener" "postfix_prometheus_node_exporter" {
  load_balancer_arn = aws_lb.postfix_nlb.arn
  port              = 9100
  protocol          = "TCP"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.postfix_prometheus_node_exporter.arn
  }
}

resource "aws_lb_target_group" "postfix_prometheus_postfix_exporter" {
  name        = "${terraform.workspace}-postfix-exporter"
  port        = 9154
  protocol    = "TCP"
  vpc_id      = module.postfix_vpc.vpc_id
  target_type = "instance"

  health_check {
    protocol            = "TCP"
    port                = 9100
    interval            = 10
    healthy_threshold   = 10
    unhealthy_threshold = 10
  }

  tags = var.tags
}

resource "aws_lb_listener" "postfix_prometheus_postfix_exporter" {
  load_balancer_arn = aws_lb.postfix_nlb.arn
  port              = 9154
  protocol          = "TCP"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.postfix_prometheus_postfix_exporter.arn
  }
}


resource "aws_lb_target_group_attachment" "postfix_smtp" {
  count = length(module.postfix_vpc.private_subnets)

  target_group_arn = aws_lb_target_group.postfix_smtp.arn
  target_id        = aws_instance.postfix[count.index].id
  port             = 25
}

resource "aws_lb_target_group_attachment" "postfix_smtps" {
  count = length(module.postfix_vpc.private_subnets)

  target_group_arn = aws_lb_target_group.postfix_smtps.arn
  target_id        = aws_instance.postfix[count.index].id
  port             = 465
}

resource "aws_lb_target_group_attachment" "postfix_prometheus_node_exporter" {
  count = length(module.postfix_vpc.private_subnets)

  target_group_arn = aws_lb_target_group.postfix_prometheus_node_exporter.arn
  target_id        = aws_instance.postfix[count.index].id
  port             = 9100
}

resource "aws_lb_target_group_attachment" "postfix_prometheus_postfix_exporter" {
  count = length(module.postfix_vpc.private_subnets)

  target_group_arn = aws_lb_target_group.postfix_prometheus_postfix_exporter.arn
  target_id        = aws_instance.postfix[count.index].id
  port             = 9154
}

resource "aws_vpc_endpoint_service" "postfix" {
  acceptance_required = false
  network_load_balancer_arns = [
    aws_lb.postfix_nlb.arn
  ]

  allowed_principals = formatlist(
    "arn:aws:iam::%s:root", [
      data.aws_caller_identity.current.account_id
    ]
  )

  tags = var.tags
}


### Cloudwatch configuration files
resource "aws_ssm_parameter" "cloudwatch_agent_configuration_file" {
  name  = "/${var.name}/postfix/cloudwatch/agent"
  type  = "SecureString"
  value = data.template_file.bastion_cloudwatch_agent.rendered
  tier  = "Advanced"

  tags = var.tags
}

#### Postfix ecs cluster
resource "aws_kms_key" "logging_encryption_key" {
  description = "${var.name}-postfix-cloudwatch-key"

  enable_key_rotation     = true
  deletion_window_in_days = 7

  policy = data.template_file.allow_kms.rendered

  tags = var.tags
}

resource "aws_kms_alias" "logging_encryption_key_alias" {
  target_key_id = aws_kms_key.logging_encryption_key.arn
  name          = "alias/${aws_kms_key.logging_encryption_key.description}"
}

resource "aws_cloudwatch_log_group" "postfix_log_group" {
  name              = "${var.name}-postfix-ecs-logs"
  retention_in_days = local.log_retention
  kms_key_id        = aws_kms_key.logging_encryption_key.arn

  tags = var.tags
}

module "postfix_nlb" {
  source             = "github.com/ministryofjustice/bichard7-next-infrastructure-modules.git//modules/ecs_cluster_alb"
  load_balancer_type = "network"
  vpc_id             = module.postfix_vpc.vpc_id

  alb_listener = [
    {
      port     = 2525
      protocol = "TCP"
    }
  ]
  default_action = [
    [
      {
        type = "forward"
      }
    ]
  ]

  alb_name        = trim(substr("${var.name}-postfix", 0, 32), "-")
  alb_name_prefix = "psmtp"
  alb_port        = 25

  alb_protocol        = "TCP"
  logging_bucket_name = var.aws_logs_bucket
  service_subnets     = module.postfix_vpc.private_subnets
  tags                = var.tags
}

resource "aws_alb_target_group" "postfix_smtps" {
  name_prefix = "psmtps"
  port        = 445
  protocol    = "TCP"
  vpc_id      = module.postfix_vpc.vpc_id
  target_type = "ip"

  health_check {
    healthy_threshold   = 10
    interval            = 30
    protocol            = "TCP"
    unhealthy_threshold = 10
  }

  lifecycle {
    create_before_destroy = true
  }

  tags = var.tags
}

# tfsec:ignore:AWS004
resource "aws_alb_listener" "postfix_ecs_smtps" {
  load_balancer_arn = module.postfix_nlb.load_balancer.arn
  port              = 4545
  protocol          = "TCP"

  default_action {
    type             = "forward"
    target_group_arn = aws_alb_target_group.postfix_smtps.arn
  }

  tags = var.tags
}

module "postfix_ecs_cluster" {
  source       = "github.com/ministryofjustice/bichard7-next-infrastructure-modules.git//modules/ecs_cluster"
  cluster_name = "${var.name}-postfix"
  ecr_repository_arns = [
    var.postfix_ecs.repository_arn
  ]
  log_group_name           = aws_cloudwatch_log_group.postfix_log_group.name
  rendered_task_definition = base64encode(data.template_file.postfix_ecs_task.rendered)
  security_group_name      = aws_security_group.postfix_instance.name
  service_subnets          = module.postfix_vpc.private_subnets
  tags                     = var.tags

  container_count        = 3
  enable_execute_command = true
  ssm_resources = [
    data.aws_ssm_parameter.cjse_client_certificate.arn,
    data.aws_ssm_parameter.cjse_relay_password.arn,
    data.aws_ssm_parameter.cjse_relay_user.arn,
    data.aws_ssm_parameter.cjse_root_certificate.arn,
    aws_ssm_parameter.public_domain_signing_key.arn
  ]
  service_name = "postfix"

  load_balancers = [
    {
      target_group_arn = module.postfix_nlb.target_group.arn
      container_name   = "postfix"
      container_port   = module.postfix_nlb.target_group.port
    }
  ]
}
