# Postfix smtp user
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
# VPC Endpoint Service
resource "aws_vpc_endpoint_service" "postfix" {
  acceptance_required = false
  network_load_balancer_arns = [
    module.postfix_nlb.load_balancer.arn
  ]

  allowed_principals = formatlist(
    "arn:aws:iam::%s:root", [
      data.aws_caller_identity.current.account_id
    ]
  )

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
  port        = 465
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
  security_group_name      = aws_security_group.postfix_container.name
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
