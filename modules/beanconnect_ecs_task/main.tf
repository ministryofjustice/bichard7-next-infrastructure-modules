resource "aws_ssm_parameter" "beanconnect_deploy_tag" {
  name      = "/${var.name}/beanconnect/image_hash"
  type      = "SecureString"
  value     = var.beanconnect_ecs_image_hash
  overwrite = true

  tags = var.tags
}

resource "random_password" "beanconnect" {
  length  = 16
  special = true
}

resource "aws_ssm_parameter" "beanconnect_password" {
  name      = "/${var.name}/ecr/beanconnect/password"
  type      = "SecureString"
  value     = random_password.beanconnect.result
  overwrite = true

  tags = local.tags
}

module "beanconnect_ecs_alb" {
  source = "github.com/ministryofjustice/bichard7-next-infrastructure-modules.git//modules/ecs_cluster_alb"
  alb_listener = [
    {
      port     = 31004
      protocol = "TCP"
    }
  ]
  default_action = [
    [{
      type = "forward"
    }]
  ]
  alb_name            = local.alb_name
  alb_name_prefix     = local.alb_name_prefix
  alb_port            = 31004
  logging_bucket_name = var.logging_bucket_name
  service_subnets     = var.service_subnets
  vpc_id              = var.vpc_id
  load_balancer_type  = "network"
  alb_protocol        = "TCP"

  tags = local.tags
}

module "beanconnect_ecs_service" {
  source = "github.com/ministryofjustice/bichard7-next-infrastructure-modules.git//modules/ecs_cluster"

  cluster_name             = local.name
  ecr_repository_arns      = [var.beanconnect_repo_arn]
  log_group_name           = var.beanconnect_log_group.name
  rendered_task_definition = base64encode(data.template_file.beanconnect_fargate.rendered)
  security_group_name      = data.aws_security_group.beanconnect.name
  service_subnets          = var.service_subnets
  ssm_resources            = local.allowed_resources
  container_count          = var.desired_instance_count
  enable_execute_command   = true #var.using_pnc_emulator == 1 ? true : false

  load_balancers = [
    {
      target_group_arn = module.beanconnect_ecs_alb.target_group.arn
      container_name   = "beanconnect"
      container_port   = 31004
    }
  ]
  fargate_cpu    = var.fargate_cpu
  fargate_memory = var.fargate_memory

  tags = local.tags
}

resource "aws_route53_record" "bc" {
  name    = "bc.${data.aws_route53_zone.cjse_dot_org.name}"
  type    = "CNAME"
  zone_id = var.private_zone_id
  ttl     = 30

  records = [
    module.beanconnect_ecs_alb.dns_name
  ]
}
