resource "aws_ssm_parameter" "user_service_deploy_tag" {
  name      = "/${var.name}/user_service/image_hash"
  type      = "SecureString"
  value     = var.user_service_ecs_image_hash
  overwrite = var.override_deploy_tags

  lifecycle {
    ignore_changes = [
      value
    ]
  }

  tags = var.tags
}

module "user_service_alb" {
  source = "github.com/ministryofjustice/bichard7-next-infrastructure-modules.git//modules/ecs_cluster_alb?ref=remove-AWSLogs-s3-prefix"

  alb_security_groups = [
    data.aws_security_group.user_service_alb.id
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
    [
      {
        type = "redirect"
      }
    ],
    [
      {
        type = "forward"
      }
    ]
  ]

  alb_health_check = {
    protocol            = "HTTPS"
    port                = 443
    interval            = 10
    healthy_threshold   = 3
    unhealthy_threshold = 10
    path                = "/elb-status"
    matcher             = 200
  }

  alb_name            = local.alb_name
  alb_name_prefix     = local.alb_name_prefix
  alb_port            = 443
  logging_bucket_name = var.logging_bucket_name
  service_subnets     = var.service_subnets
  vpc_id              = var.vpc_id
  alb_protocol        = "HTTPS"

  tags = local.tags
}

module "user_service_ecs" {
  source = "github.com/ministryofjustice/bichard7-next-infrastructure-modules.git//modules/ecs_cluster"

  ecr_repository_arns = [
    var.user_service_ecs_arn,
  ]

  cluster_name             = local.name
  log_group_name           = var.user_service_log_group.name
  rendered_task_definition = base64encode(data.template_file.user_service_fargate.rendered)
  security_group_name      = data.aws_security_group.user_service_ecs.name
  service_subnets          = var.service_subnets
  container_count          = var.desired_instance_count
  enable_execute_command   = true

  load_balancers = [
    {
      target_group_arn = module.user_service_alb.target_group.arn
      container_name   = "user-service"
      container_port   = 443
    }
  ]
  fargate_cpu    = var.fargate_cpu
  fargate_memory = var.fargate_memory

  ssm_resources = [
    var.db_password_arn,
    var.jwt_secret_arn,
    var.cookie_secret_arn,
    var.crsf_form_secret_arn,
    var.csrf_cookie_secret_arn
  ]

  tags = local.tags
}

resource "aws_route53_record" "user_service" {
  name    = "users.${data.aws_route53_zone.public_zone.name}"
  type    = "CNAME"
  zone_id = var.public_zone_id
  ttl     = 30

  records = [
    module.user_service_alb.dns_name
  ]
}
