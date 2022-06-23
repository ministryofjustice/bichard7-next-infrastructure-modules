resource "aws_ssm_parameter" "nginx_auth_proxy_deploy_tag" {
  name      = "/${var.name}/nginx_auth_proxy/image_hash"
  type      = "SecureString"
  value     = var.nginx_auth_proxy_ecs_image_hash
  overwrite = var.override_deploy_tags

  lifecycle {
    ignore_changes = [
      value
    ]
  }

  tags = var.tags
}

//module "nginx_auth_proxy_alb" {
//  source = "github.com/ministryofjustice/bichard7-next-infrastructure-modules.git//modules/ecs_cluster_alb?ref=upgrade-aws-provider"
//
//  alb_security_groups = [
//    data.aws_security_group.nginx_auth_proxy_alb.id
//  ]
//
//  alb_listener = [
//    {
//      port     = 80
//      protocol = "HTTP"
//    },
//    {
//      port            = 443
//      protocol        = "HTTPS"
//      certificate_arn = var.ssl_certificate_arn
//    }
//  ]
//
//  # We need an empty config for each non redirecting block
//  redirect_config = [[], []]
//
//  default_action = [
//    [
//      {
//        type = "forward"
//      }
//    ],
//    [
//      {
//        type = "forward"
//      }
//    ]
//  ]
//
//  alb_health_check = {
//    protocol            = "HTTPS"
//    port                = 443
//    interval            = 10
//    healthy_threshold   = 3
//    unhealthy_threshold = 10
//    path                = "/elb-status"
//    matcher             = 200
//  }
//
//  alb_name            = local.alb_name
//  alb_name_prefix     = local.alb_name_prefix
//  alb_port            = 443
//  logging_bucket_name = var.logging_bucket_name
//  service_subnets     = var.service_subnets
//  vpc_id              = var.vpc_id
//  alb_protocol        = "HTTPS"
//
//  tags = local.tags
//}

module "nginx_auth_proxy_ecs" {
  source = "github.com/ministryofjustice/bichard7-next-infrastructure-modules.git//modules/ecs_cluster?ref=upgrade-aws-provider"

  ecr_repository_arns = [
    var.nginx_auth_proxy_ecs_arn,
  ]

  cluster_name             = local.name
  log_group_name           = var.nginx_auth_proxy_log_group.name
  rendered_task_definition = base64encode(data.template_file.nginx_auth_proxy_fargate.rendered)
  security_group_name      = data.aws_security_group.nginx_auth_proxy_ecs.name
  service_subnets          = var.service_subnets
  container_count          = var.desired_instance_count
  enable_execute_command   = true

  load_balancers = [
    {
      target_group_arn = aws_lb_target_group.alb_target_group_https.arn
      container_name   = "nginx-auth-proxy"
      container_port   = 443
    },
    {
      target_group_arn = aws_lb_target_group.alb_target_group_http.arn
      container_name   = "nginx-auth-proxy"
      container_port   = 80
    }
  ]
  fargate_cpu    = var.fargate_cpu
  fargate_memory = var.fargate_memory

  tags = local.tags
}

resource "aws_route53_record" "nginx_auth_proxy" {
  name    = "proxy.${data.aws_route53_zone.public_zone.name}"
  type    = "CNAME"
  zone_id = var.public_zone_id
  ttl     = 30

  records = [
    aws_alb.auth_proxy_alb.dns_name
  ]
}
