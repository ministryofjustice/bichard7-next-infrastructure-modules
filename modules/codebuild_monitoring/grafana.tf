#resource "aws_ecs_task_definition" "grafana_ecs_task" {
#  family             = "${var.name}-grafana"
#  execution_role_arn = aws_iam_role.prometheus_task_role.arn
#
#  network_mode             = "awsvpc"
#  requires_compatibilities = ["FARGATE"]
#  memory                   = var.fargate_memory
#  cpu                      = var.fargate_cpu
#
#  task_role_arn         = aws_iam_role.prometheus_task_role.arn
#  container_definitions = data.template_file.grafana_ecs_task.rendered
#
#  tags = var.tags
#}
#
#resource "aws_ecs_service" "grafana_ecs_service" {
#  name            = "${var.name}-grafana"
#  cluster         = aws_ecs_cluster.monitoring_cluster.id
#  task_definition = aws_ecs_task_definition.grafana_ecs_task.arn
#  desired_count   = 1
#  launch_type     = "FARGATE"
#
#  enable_execute_command = var.remote_exec_enabled
#
#  network_configuration {
#    security_groups = [
#      data.aws_security_group.grafana_security_group.id
#    ]
#    subnets = var.service_subnets
#  }
#
#  load_balancer {
#    target_group_arn = aws_lb_target_group.grafana_alb_target_group.id
#    container_name   = "grafana"
#    container_port   = 3000
#  }
#  depends_on = [aws_lb_listener.grafana_https_listener]
#
#  tags = var.tags
#}
#
#resource "aws_alb" "grafana_alb" {
#  name = local.grafana_alb_name
#
#  subnets = var.service_subnets
#
#  security_groups = [
#    data.aws_security_group.grafana_alb_security_group.id
#  ]
#  internal     = true
#  idle_timeout = var.idle_timeout
#
#  access_logs {
#    bucket  = var.logging_bucket_name
#    enabled = true
#    prefix  = "alb/AWSLogs/${data.aws_caller_identity.current.account_id}/${local.grafana_alb_name}"
#  }
#
#  enable_deletion_protection = (lower(var.tags["is-production"]) == "true") ? true : false
#  drop_invalid_header_fields = true
#
#  tags = var.tags
#}
#
#resource "aws_lb_target_group" "grafana_alb_target_group" {
#  name_prefix = local.grafana_alb_name_prefix
#  port        = 3000
#  protocol    = "HTTPS"
#  vpc_id      = var.vpc_id
#  target_type = "ip"
#
#  health_check {
#    healthy_threshold   = "3"
#    port                = 3000
#    interval            = "30"
#    protocol            = "HTTPS"
#    matcher             = "200"
#    timeout             = "3"
#    path                = "/api/health"
#    unhealthy_threshold = "10"
#  }
#
#  tags = var.tags
#}
#
#resource "aws_lb_listener" "grafana_https_listener" {
#  load_balancer_arn = aws_alb.grafana_alb.arn
#  port              = 443
#  protocol          = "HTTPS"
#  ssl_policy        = "ELBSecurityPolicy-TLS-1-2-Ext-2018-06"
#  certificate_arn   = var.ssl_certificate_arn
#
#  default_action {
#    target_group_arn = aws_lb_target_group.grafana_alb_target_group.arn
#    type             = "forward"
#  }
#
#  tags = var.tags
#}
#
#resource "aws_lb_listener" "grafana_http_listener" {
#  load_balancer_arn = aws_alb.grafana_alb.arn
#  port              = 80
#  protocol          = "HTTP" #tfsec:ignore:AWS004
#
#  default_action {
#    type = "redirect"
#
#    redirect {
#      port        = "443"
#      protocol    = "HTTPS"
#      status_code = "HTTP_301"
#    }
#  }
#
#  tags = var.tags
#}
#
#resource "aws_route53_record" "db_internal" {
#  name    = "grafanadb.${data.aws_route53_zone.cjse_dot_org.name}"
#  type    = "CNAME"
#  zone_id = data.aws_route53_zone.cjse_dot_org.zone_id
#  ttl     = 30
#  records = [aws_rds_cluster.grafana_db.endpoint]
#}
#
#resource "aws_route53_record" "grafana_public_record" {
#  name    = "grafana.${var.public_zone_name}"
#  type    = "CNAME"
#  zone_id = var.public_zone_id
#  ttl     = 30
#  records = [aws_alb.grafana_alb.dns_name]
#}

module "codebuild_monitoring_ecs_cluster" {
  source       = "../ecs_cluster"
  cluster_name = "codebuild-monitoring"
  ecr_repository_arns = [
    var.grafana_repository_arn
  ]
  log_group_name           = aws_cloudwatch_log_group.codebuild_monitoring.name
  rendered_task_definition = base64encode(data.template_file.grafana_ecs_task.rendered)
  service_subnets          = var.service_subnets
  security_group_name      = aws_security_group.grafana_cluster_security_group.name
  assign_public_ip         = true
  container_count          = 1
  enable_execute_command   = true
  fargate_cpu              = var.fargate_cpu
  fargate_memory           = var.fargate_memory

  load_balancers = [
    {
      target_group_arn = module.codebuild_monitoring_ecs_alb.target_group.arn
      container_name   = "grafana"
      container_port   = 3000
    }
  ]

  tags = var.tags

  depends_on = [
    aws_security_group.grafana_cluster_security_group
  ]
}

module "codebuild_monitoring_ecs_alb" {
  source              = "../ecs_cluster_alb"
  alb_name            = local.grafana_alb_name
  alb_name_prefix     = local.grafana_alb_name_prefix
  service_subnets     = var.service_subnets
  alb_port            = 3000
  alb_protocol        = "HTTPS"
  logging_bucket_name = var.logging_bucket_name
  vpc_id              = var.vpc_id

  alb_health_check = {
    healthy_threshold   = "3"
    port                = 3000
    interval            = "30"
    protocol            = "HTTPS"
    matcher             = "200"
    timeout             = "3"
    path                = "/api/health"
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

  tags = var.tags
}
