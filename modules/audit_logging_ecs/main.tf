resource "aws_ssm_parameter" "audit_logging_deploy_tag" {
  name      = "/${var.name}/audit_logging/image_hash"
  type      = "SecureString"
  value     = var.audit_logging_portal_ecs_image_hash
  overwrite = var.override_deploy_tags

  lifecycle {
    ignore_changes = [
      value
    ]
  }

  tags = var.tags
}

module "audit_logging_portal_ecs_alb" {
  source = "github.com/ministryofjustice/bichard7-next-infrastructure-modules.git//modules/ecs_cluster_alb?ref=remove-AWSLogs-s3-prefix"

  alb_security_groups = [
    data.aws_security_group.audit_logging_portal_alb.id
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
    healthy_threshold   = 3
    port                = 443
    interval            = 30
    protocol            = "HTTPS"
    matcher             = 200
    timeout             = 3
    path                = "/audit-logging/api/status"
    unhealthy_threshold = 10
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

module "audit_logging_portal_service" {
  source = "github.com/ministryofjustice/bichard7-next-infrastructure-modules.git//modules/ecs_cluster"

  cluster_name = local.name
  ecr_repository_arns = [
    var.audit_logging_portal_ecs_arn
  ]
  log_group_name           = var.audit_logging_portal_log_group.name
  rendered_task_definition = base64encode(data.template_file.audit_logging_portal_fargate.rendered)
  security_group_name      = data.aws_security_group.audit_logging_portal.name
  service_subnets          = var.service_subnets
  ssm_resources            = [var.audit_log_api_key_arn]
  container_count          = var.desired_instance_count

  load_balancers = [
    {
      target_group_arn = module.audit_logging_portal_ecs_alb.target_group.arn
      container_name   = "audit_logging"
      container_port   = 443
    }
  ]
  fargate_cpu    = var.fargate_cpu
  fargate_memory = var.fargate_memory
  volumes = [
    {
      name = "data"
    }
  ]

  tags = local.tags
}

resource "aws_route53_record" "audit_logging" {
  name    = "audit.${data.aws_route53_zone.public_zone.name}"
  type    = "CNAME"
  zone_id = var.public_zone_id
  ttl     = 30

  records = [
    module.audit_logging_portal_ecs_alb.dns_name
  ]
}
