module "bichard_ecs_alb" {
  source              = "github.com/ministryofjustice/bichard7-next-infrastructure-modules.git//modules/ecs_cluster_alb?ref=remove-AWSLogs-s3-prefix"
  alb_name            = local.alb_name
  alb_name_prefix     = "b7app"
  alb_port            = 9443
  alb_protocol        = "HTTPS"
  logging_bucket_name = var.logging_bucket_name
  service_subnets     = var.service_subnets
  vpc_id              = var.vpc_id

  stickiness = {
    type            = "lb_cookie"
    cookie_duration = 86400
    enabled         = true
  }

  alb_health_check = {
    healthy_threshold   = 3
    port                = 9443
    interval            = 30
    protocol            = "HTTPS"
    matcher             = 200
    timeout             = 3
    path                = "/bichard-ui/Health"
    unhealthy_threshold = 10
  }

  alb_security_groups = [
    data.aws_security_group.bichard_alb.id
  ]

  alb_slow_start = 180

  default_action = [
    [{
      type = "redirect"
    }],
    [{
      type = "forward"
    }]
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

  tags = local.tags
}

module "bichard_ecs_service" {
  source                     = "github.com/ministryofjustice/bichard7-next-infrastructure-modules.git//modules/ecs_cluster"
  cluster_name               = var.cluster_name
  service_name               = local.service_name
  create_cluster             = false
  ecr_repository_arns        = [var.bichard_ecr_repository.arn]
  log_group_name             = var.bichard7_log_group.name
  rendered_task_definition   = base64encode(data.template_file.bichard_fargate.rendered)
  security_group_name        = data.aws_security_group.bichard.name
  service_subnets            = var.service_subnets
  fargate_cpu                = var.fargate_cpu
  fargate_memory             = var.fargate_memory
  container_count            = var.desired_instance_count
  enable_execute_command     = true
  remote_cluster_kms_key_arn = var.cluster_kms_key_arn

  load_balancers = [
    {
      target_group_arn = module.bichard_ecs_alb.target_group.arn
      container_name   = local.app_name
      container_port   = 9443
    }
  ]

  ssm_resources = local.allowed_resources
  tags          = local.tags
}

resource "aws_route53_record" "bichard7" {
  name    = "bichard-${var.service_type}.${data.aws_route53_zone.cjse_dot_org.name}"
  type    = "CNAME"
  zone_id = var.private_zone_id
  ttl     = 30

  records = [
    module.bichard_ecs_alb.dns_name
  ]
}


resource "aws_route53_record" "bichard_public_record" {
  name    = "bichard-${var.service_type}.${var.public_zone_name}"
  type    = "CNAME"
  zone_id = var.public_zone_id

  ttl     = 60
  records = [module.bichard_ecs_alb.dns_name]
}
