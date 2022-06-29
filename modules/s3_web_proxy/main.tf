resource "aws_cloudwatch_log_group" "ecs_log_group" {
  name       = var.name
  kms_key_id = aws_kms_key.cloudwatch_encryption.arn

  tags = var.tags
}

module "s3_web_proxy_ecs_alb" {
  source = "github.com/ministryofjustice/bichard7-next-infrastructure-modules.git//modules/ecs_cluster_alb?ref=remove-AWSLogs-s3-prefix"
  alb_security_groups = [
    aws_security_group.s3_web_proxy_alb.id
  ]
  alb_is_internal     = true
  alb_protocol        = "HTTPS"
  service_subnets     = var.service_subnets
  alb_name            = local.alb_name
  alb_name_prefix     = local.alb_name_prefix
  alb_port            = 443
  logging_bucket_name = var.logging_bucket_name
  vpc_id              = var.vpc_id
  enable_alb_logging  = false

  alb_health_check = {
    healthy_threshold   = "3"
    interval            = "30"
    protocol            = "HTTPS"
    matcher             = "200"
    timeout             = "3"
    path                = "/elb-status"
    unhealthy_threshold = "10"
  }

  alb_listener = [
    {
      port     = 80
      protocol = "HTTP"
    },
    {
      port            = 443
      protocol        = "HTTPS"
      certificate_arn = var.ssl_certificate_arn
    }
  ]

  redirect_config = [
    [
      {
        port        = "443"
        protocol    = "HTTPS"
        status_code = "HTTP_301"
      }
    ],
    []
  ]

  default_action = [
    [{
      type = "redirect"
    }],
    [{
      type = "forward"
    }]
  ]

  tags = local.tags

  depends_on = [
    aws_security_group.s3_web_proxy_alb
  ]
}

module "s3_web_proxy_ecs_service" {
  source       = "github.com/ministryofjustice/bichard7-next-infrastructure-modules.git//modules/ecs_cluster"
  cluster_name = local.name
  ecr_repository_arns = [
    var.s3_web_proxy_arn
  ]

  assign_public_ip = false

  ssm_resources = [
    aws_ssm_parameter.s3_web_proxy_access_key.arn,
    aws_ssm_parameter.s3_web_proxy_secret_key.arn
  ]

  log_group_name           = aws_cloudwatch_log_group.ecs_log_group.name
  rendered_task_definition = base64encode(data.template_file.s3_web_proxy_fargate.rendered)
  security_group_name      = aws_security_group.s3_web_proxy_container.name
  service_subnets          = var.service_subnets
  container_count          = var.desired_instance_count
  load_balancers = [
    {
      target_group_arn = module.s3_web_proxy_ecs_alb.target_group.arn
      container_name   = var.name
      container_port   = 443
    }
  ]

  fargate_cpu    = var.fargate_cpu
  fargate_memory = var.fargate_memory

  tags = local.tags

  depends_on = [
    aws_security_group.s3_web_proxy_container
  ]
}

resource "aws_route53_record" "friendly_dns_name" {
  name    = "static-files.${data.aws_route53_zone.public.name}"
  type    = "CNAME"
  zone_id = data.aws_route53_zone.public.zone_id
  ttl     = 30
  records = [
    module.s3_web_proxy_ecs_alb.dns_name
  ]
}
