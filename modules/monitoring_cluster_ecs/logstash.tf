resource "aws_ecs_task_definition" "logstash_tasks" {
  family             = "${var.name}-logstash"
  execution_role_arn = aws_iam_role.prometheus_task_role.arn

  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  memory                   = 4096
  cpu                      = 2048

  task_role_arn         = aws_iam_role.prometheus_task_role.arn
  container_definitions = data.template_file.logstash.rendered

  tags = var.tags
}

resource "aws_ecs_service" "logstash_service" {
  name            = "${var.name}-logstash"
  cluster         = aws_ecs_cluster.monitoring_cluster.id
  task_definition = aws_ecs_task_definition.logstash_tasks.arn
  desired_count   = 1
  launch_type     = "FARGATE"

  enable_execute_command = var.remote_exec_enabled

  network_configuration {
    security_groups = [
      data.aws_security_group.logstash_security_group.id
    ]
    subnets = var.service_subnets
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.logstash_alb.id
    container_name   = "logstash"
    container_port   = 9600
  }
  depends_on = [aws_lb_listener.logstash_https_listener]

  tags = var.tags
}

resource "aws_alb" "logstash_alb" {
  name = local.logstash_alb_name

  subnets = var.service_subnets
  security_groups = [
    data.aws_security_group.logstash_alb_security_group.id
  ]
  internal     = true
  idle_timeout = var.idle_timeout

  access_logs {
    bucket  = var.logging_bucket_name
    enabled = true
    prefix  = "alb/AWSLogs/${data.aws_caller_identity.current.account_id}/${local.cloudwatch_alb_name}"
  }

  enable_deletion_protection = (lower(var.tags["is-production"]) == "true") ? true : false
  drop_invalid_header_fields = true

  tags = var.tags
}

resource "aws_lb_target_group" "logstash_alb" {
  name_prefix = local.logstash_alb_name_prefix
  port        = 9600
  protocol    = "HTTP"
  vpc_id      = var.vpc_id
  target_type = "ip"

  health_check {
    healthy_threshold   = "3"
    port                = 9600
    interval            = "30"
    protocol            = "HTTP"
    matcher             = "200"
    timeout             = "3"
    path                = "/_node"
    unhealthy_threshold = "10"
  }

  tags = var.tags
}

resource "aws_lb_listener" "logstash_https_listener" {
  load_balancer_arn = aws_alb.logstash_alb.arn
  port              = 9600
  protocol          = "HTTPS"
  certificate_arn   = var.ssl_certificate_arn

  default_action {
    target_group_arn = aws_lb_target_group.logstash_alb.arn
    type             = "forward"
  }

  tags = var.tags
}

resource "aws_route53_record" "logstash_private_dns" {
  name    = "logstash.${data.aws_route53_zone.cjse_dot_org.name}"
  type    = "CNAME"
  zone_id = var.private_zone_id
  ttl     = 60
  records = [aws_alb.logstash_alb.dns_name]
}
