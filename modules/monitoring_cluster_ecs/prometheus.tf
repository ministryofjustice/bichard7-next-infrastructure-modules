resource "random_password" "admin_htaccess_password" {
  length  = 24
  special = false
}

resource "aws_ssm_parameter" "admin_htaccess_username" {
  name      = "/${var.name}/monitoring/prometheus/username"
  type      = "SecureString"
  value     = "bichard"
  overwrite = true

  tags = var.tags
}

resource "aws_ssm_parameter" "admin_htaccess_password" {
  name      = "/${var.name}/monitoring/prometheus/password"
  type      = "SecureString"
  value     = random_password.admin_htaccess_password.result
  overwrite = true

  tags = var.tags
}

resource "aws_ecs_task_definition" "prometheus_tasks" {
  family             = "${var.name}-prometheus"
  execution_role_arn = aws_iam_role.prometheus_task_role.arn

  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  memory                   = 4096
  cpu                      = 2048

  task_role_arn         = aws_iam_role.prometheus_task_role.arn
  container_definitions = data.template_file.prometheus_ecs_task.rendered

  volume {
    name = "${var.name}-prometheus-data"
    efs_volume_configuration {
      file_system_id          = var.prometheus_efs_filesystem_id
      root_directory          = "/"
      transit_encryption      = "ENABLED"
      transit_encryption_port = 2149
      authorization_config {
        access_point_id = var.efs_access_points.prometheus.id
        iam             = "ENABLED"
      }
    }
  }

  tags = var.tags
}

resource "aws_ecs_service" "prometheus_service" {
  name            = "${var.name}-prometheus"
  cluster         = aws_ecs_cluster.monitoring_cluster.id
  task_definition = aws_ecs_task_definition.prometheus_tasks.arn
  desired_count   = 1
  launch_type     = "FARGATE"

  enable_execute_command = var.remote_exec_enabled

  network_configuration {
    security_groups = [
      data.aws_security_group.prometheus_security_group.id
    ]
    subnets = var.service_subnets
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.prometheus_alb.id
    container_name   = "prometheus"
    container_port   = 9090
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.prometheus_alert_manager_alb.arn
    container_name   = "prometheus"
    container_port   = 9092
  }

  depends_on = [aws_lb_listener.prometheus_http_listener]

  tags = var.tags
}

resource "aws_alb" "prometheus_alb" {
  name = local.prometheus_alb_name

  subnets = var.service_subnets

  security_groups = [
    data.aws_security_group.prometheus_alb.id
  ]
  internal = true

  access_logs {
    bucket  = var.logging_bucket_name
    enabled = true
    prefix  = "alb/AWSLogs/${data.aws_caller_identity.current.account_id}/${local.prometheus_alb_name}"
  }

  enable_deletion_protection = (lower(var.tags["is-production"]) == "true") ? true : false
  drop_invalid_header_fields = true

  tags = var.tags
}

resource "aws_alb" "prometheus_alert_manager_alb" {
  name = local.prometheus_alert_alb_name

  subnets = var.service_subnets

  security_groups = [
    data.aws_security_group.prometheus_alert_manager_alb.id
  ]
  internal = true

  access_logs {
    bucket  = var.logging_bucket_name
    enabled = true
    prefix  = "alb/AWSLogs/${data.aws_caller_identity.current.account_id}/${local.prometheus_alert_alb_name}"
  }

  enable_deletion_protection = (lower(var.tags["is-production"]) == "true") ? true : false
  drop_invalid_header_fields = true

  tags = var.tags
}

resource "aws_lb_target_group" "prometheus_alb" {
  name_prefix = local.prometheus_alb_name_prefix
  port        = 9090
  protocol    = "HTTPS"
  vpc_id      = var.vpc_id
  target_type = "ip"

  health_check {
    healthy_threshold   = "3"
    port                = 9090
    interval            = "30"
    protocol            = "HTTPS"
    matcher             = "200"
    timeout             = "3"
    path                = "/elb-status"
    unhealthy_threshold = "10"
  }

  tags = var.tags
}

resource "aws_lb_target_group" "prometheus_alert_manager_alb" {
  name_prefix = local.prometheus_alert_alb_name_prefix
  port        = 9092
  protocol    = "HTTPS"
  vpc_id      = var.vpc_id
  target_type = "ip"

  health_check {
    healthy_threshold   = "3"
    port                = 9092
    interval            = "30"
    protocol            = "HTTPS"
    matcher             = "200"
    timeout             = "3"
    path                = "/elb-status"
    unhealthy_threshold = "10"
  }

  tags = var.tags
}

resource "aws_lb_listener" "prometheus_http_listener" {
  load_balancer_arn = aws_alb.prometheus_alb.arn
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

resource "aws_lb_listener" "prometheus_https_listener" {
  load_balancer_arn = aws_alb.prometheus_alb.arn
  port              = 443
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-TLS-1-2-Ext-2018-06"
  certificate_arn   = var.ssl_certificate_arn

  default_action {
    target_group_arn = aws_lb_target_group.prometheus_alb.arn
    type             = "forward"
  }

  tags = var.tags
}

resource "aws_lb_listener" "prometheus_alert_manager_https_listener" {
  load_balancer_arn = aws_alb.prometheus_alert_manager_alb.arn
  port              = 443
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-TLS-1-2-Ext-2018-06"
  certificate_arn   = var.ssl_certificate_arn

  default_action {
    target_group_arn = aws_lb_target_group.prometheus_alert_manager_alb.arn
    type             = "forward"
  }

  tags = var.tags
}

resource "aws_route53_record" "prometheus_public_record" {
  name    = "prometheus.${var.public_zone_name}"
  type    = "CNAME"
  zone_id = var.public_zone_id

  ttl     = 60
  records = [aws_alb.prometheus_alb.dns_name]
}

resource "aws_route53_record" "prometheus_alert_manager_public_record" {
  name    = "alerts.${var.public_zone_name}"
  type    = "CNAME"
  zone_id = var.public_zone_id

  ttl     = 60
  records = [aws_alb.prometheus_alert_manager_alb.dns_name]
}

resource "aws_route53_record" "prometheus_internal_record" {
  name    = "prometheus.${data.aws_route53_zone.cjse_dot_org.name}"
  type    = "CNAME"
  zone_id = data.aws_route53_zone.cjse_dot_org.zone_id

  ttl     = 30
  records = [aws_alb.prometheus_alb.dns_name]
}


resource "aws_route53_record" "prometheus_alert_manager_internal_record" {
  name    = "alerts.${data.aws_route53_zone.cjse_dot_org.name}"
  type    = "CNAME"
  zone_id = data.aws_route53_zone.cjse_dot_org.zone_id

  ttl     = 30
  records = [aws_alb.prometheus_alb.dns_name]
}
