module "pncemulator_ecs_alb" {
  source              = "github.com/ministryofjustice/bichard7-next-infrastructure-modules.git//modules/ecs_cluster_alb?ref=remove-AWSLogs-s3-prefix"
  load_balancer_type  = "network"
  service_subnets     = var.service_subnets
  alb_name            = local.alb_name
  alb_name_prefix     = local.alb_utm_name_prefix
  alb_port            = 30001
  logging_bucket_name = var.logging_bucket_name
  vpc_id              = var.vpc_id
  alb_health_check = {
    healthy_threshold   = 3
    interval            = 30
    protocol            = "TCP"
    unhealthy_threshold = 3
  }
  alb_listener = [
    {
      port     = 30001
      protocol = "TCP"
    }
  ]
  default_action = [
    [{
      type = "forward"
    }]
  ]

  tags = local.tags
}

module "pncemulator_ecs_service" {
  source                   = "github.com/ministryofjustice/bichard7-next-infrastructure-modules.git//modules/ecs_cluster"
  cluster_name             = local.name
  ecr_repository_arns      = [var.pncemulator_repo_arn]
  log_group_name           = var.pncemulator_log_group.name
  rendered_task_definition = base64encode(data.template_file.pncemulator_fargate.rendered)
  security_group_name      = data.aws_security_group.pncemulator.name
  service_subnets          = var.service_subnets
  container_count          = 1
  enable_execute_command   = true
  logging_bucket_name      = var.logging_bucket_name

  load_balancers = [
    {
      target_group_arn = module.pncemulator_ecs_alb.target_group.arn
      container_name   = "pncemulator"
      container_port   = 30001
    },
    {
      target_group_arn = aws_lb_target_group.pncemulator_api.arn
      container_name   = "pncemulator"
      container_port   = 3000
    }

  ]
  fargate_cpu    = var.fargate_cpu
  fargate_memory = var.fargate_memory

  tags = local.tags
}

resource "aws_lb_target_group" "pncemulator_api" {
  name_prefix = local.alb_api_name_prefix
  port        = 3000
  protocol    = "TCP"
  vpc_id      = var.vpc_id
  target_type = "ip"

  health_check {
    healthy_threshold   = 3
    interval            = 30
    protocol            = "TCP"
    unhealthy_threshold = 3
  }

  lifecycle {
    create_before_destroy = true
  }

  tags = local.tags
}

# Redirect all traffic from the API NLB to the target group
resource "aws_lb_listener" "pncemulator_api_listener" {
  load_balancer_arn = module.pncemulator_ecs_alb.load_balancer.arn
  port              = 3000
  protocol          = "TCP" # tfsec:ignore:aws-elbv2-http-not-used

  default_action {
    target_group_arn = aws_lb_target_group.pncemulator_api.arn
    type             = "forward"
  }

  tags = local.tags
}
