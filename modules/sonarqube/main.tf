resource "aws_ecs_task_definition" "sonar_tasks" {
  family             = "${var.name}-sonar"
  execution_role_arn = aws_iam_role.sonarqube_task_role.arn

  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  memory                   = 4096
  cpu                      = 2048

  task_role_arn         = aws_iam_role.sonarqube_task_role.arn
  container_definitions = data.template_file.sonarqube_ecs_task.rendered

  tags = var.tags
}

resource "aws_ecs_service" "sonar_service" {
  name             = "${var.name}-sonar"
  cluster          = aws_ecs_cluster.sonarqube_cluster.id
  task_definition  = aws_ecs_task_definition.sonar_tasks.arn
  desired_count    = 1
  launch_type      = "FARGATE"
  platform_version = "1.4.0"

  deployment_controller {
    type = "ECS"
  }

  network_configuration {
    security_groups = [
      aws_security_group.sonar_security_group.id,
      aws_security_group.sonar_github_git_traffic.id,
      aws_security_group.sonar_github_web_traffic.id,
      aws_security_group.sonar_github_ssh_traffic.id
    ]
    subnets          = module.vpc.public_subnets
    assign_public_ip = true
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.sonar_alb.id
    container_name   = "sonarqube"
    container_port   = 9000
  }

  depends_on = [aws_lb_listener.sonar_http_listener]

  tags = var.tags
}

# tfsec:ignore:AWS005
resource "aws_alb" "sonar_alb" {
  name = local.sonar_alb_name

  subnets         = module.vpc.public_subnets
  security_groups = [aws_security_group.sonar_alb.id]

  access_logs {
    bucket  = var.logging_bucket_name
    enabled = true
    prefix  = "alb/AWSLogs/${data.aws_caller_identity.current.account_id}/${local.sonar_alb_name}"
  }

  enable_deletion_protection = false
  drop_invalid_header_fields = true

  tags = var.tags
}

resource "aws_lb_target_group" "sonar_alb" {
  name_prefix = local.sonar_alb_name_prefix
  port        = 9000
  protocol    = "HTTP"
  vpc_id      = module.vpc.vpc_id
  target_type = "ip"
  slow_start  = 240

  health_check {
    healthy_threshold   = "3"
    port                = 9000
    interval            = "30"
    protocol            = "HTTP"
    matcher             = "200"
    timeout             = "3"
    path                = "/"
    unhealthy_threshold = "10"
  }

  tags = var.tags
}

resource "aws_lb_listener" "sonar_http_listener" {
  load_balancer_arn = aws_alb.sonar_alb.arn
  port              = 80
  protocol          = "HTTP" #tfsec:ignore:AWS004

  default_action {
    type = "redirect"

    redirect {
      port        = "443"
      protocol    = "HTTPS"
      status_code = "HTTP_301"
    }
  }

  tags = var.tags
}

resource "aws_lb_listener" "sonar_https_listener" {
  load_balancer_arn = aws_alb.sonar_alb.arn
  port              = 443
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-TLS-1-2-Ext-2018-06"
  certificate_arn   = aws_acm_certificate.base_infra_certificate.arn

  default_action {
    target_group_arn = aws_lb_target_group.sonar_alb.arn
    type             = "forward"
  }

  tags = var.tags
}
