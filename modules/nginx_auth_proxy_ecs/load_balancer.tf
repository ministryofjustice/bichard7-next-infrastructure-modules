resource "aws_alb" "auth_proxy_alb" {
  name = local.alb_name

  load_balancer_type = "application"
  ip_address_type    = "ipv4"
  subnets            = var.service_subnets
  security_groups = [
    data.aws_security_group.nginx_auth_proxy_alb.id
  ]
  internal = true #tfsec:ignore:AWS005

  access_logs {
    bucket  = var.logging_bucket_name
    enabled = true
    prefix  = "alb/${data.aws_caller_identity.current.account_id}/${local.alb_name}"
  }

  enable_deletion_protection = (lower(var.tags["is-production"]) == "true") ? true : false
  drop_invalid_header_fields = true

  tags = var.tags
}

resource "aws_lb_target_group" "alb_target_group_https" {
  name_prefix = local.alb_name_prefix
  port        = 443
  protocol    = "HTTPS"
  vpc_id      = var.vpc_id
  target_type = "ip"
  slow_start  = 0

  health_check {
    healthy_threshold   = 3
    interval            = 10
    protocol            = "HTTPS"
    unhealthy_threshold = 10
    matcher             = 200
    path                = "/elb-status"
  }

  lifecycle {
    create_before_destroy = true
  }

  tags = var.tags
}

resource "aws_lb_target_group" "alb_target_group_http" {
  name_prefix = local.alb_name_prefix
  port        = 80
  protocol    = "HTTP"
  vpc_id      = var.vpc_id
  target_type = "ip"
  slow_start  = 0

  health_check {
    healthy_threshold   = 3
    interval            = 10
    protocol            = "HTTP"
    unhealthy_threshold = 10
    matcher             = 200
    path                = "/elb-status"
    timeout             = null
  }

  lifecycle {
    create_before_destroy = true
  }

  tags = var.tags
}

resource "aws_lb_listener" "alb_listener_https" {
  load_balancer_arn = aws_alb.auth_proxy_alb.arn
  port              = 443
  protocol          = "HTTPS" # tfsec:ignore:aws-elbv2-http-not-used

  ssl_policy      = "ELBSecurityPolicy-TLS-1-2-Ext-2018-06"
  certificate_arn = var.ssl_certificate_arn

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.alb_target_group_https.arn
  }

  tags = var.tags
}

resource "aws_lb_listener" "alb_listener_http" {
  load_balancer_arn = aws_alb.auth_proxy_alb.arn
  port              = 80
  protocol          = "HTTP" # tfsec:ignore:AWS004

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.alb_target_group_http.arn
  }

  tags = var.tags
}
