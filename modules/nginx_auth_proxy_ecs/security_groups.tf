resource "aws_security_group_rule" "allow_http_to_alb_from_vpc" {
  description = "Allow access from alb to instances"

  from_port         = 80
  protocol          = "tcp"
  security_group_id = data.aws_security_group.nginx_auth_proxy_alb.id
  to_port           = 80
  type              = "ingress"

  cidr_blocks = var.admin_allowed_cidr
}

resource "aws_security_group_rule" "allow_https_to_alb_from_vpc" {
  description = "Allow access from alb to instances"

  from_port         = 443
  protocol          = "tcp"
  security_group_id = data.aws_security_group.nginx_auth_proxy_alb.id
  to_port           = 443
  type              = "ingress"

  cidr_blocks = var.admin_allowed_cidr
}

resource "aws_security_group_rule" "allow_all_outbound_http" {
  description = "Allow all outbound HTTP traffic to our VPC"

  from_port         = 80
  protocol          = "tcp"
  to_port           = 80
  security_group_id = data.aws_security_group.nginx_auth_proxy_alb.id
  type              = "egress"

  cidr_blocks = var.admin_allowed_cidr
}

resource "aws_security_group_rule" "allow_all_outbound_https" {
  description = "Allow all outbound HTTPS traffic to our VPC"

  from_port         = 443
  protocol          = "tcp"
  to_port           = 443
  security_group_id = data.aws_security_group.nginx_auth_proxy_alb.id
  type              = "egress"

  cidr_blocks = var.admin_allowed_cidr
}

resource "aws_security_group_rule" "allow_alb_https_to_containers" {
  description = "Allow HTTP traffic to our containers"

  from_port         = 443
  protocol          = "tcp"
  to_port           = 443
  security_group_id = data.aws_security_group.nginx_auth_proxy_alb.id
  type              = "egress"

  source_security_group_id = data.aws_security_group.nginx_auth_proxy_ecs.id
}

resource "aws_security_group_rule" "allow_alb_http_to_containers" {
  description = "Allow HTTP traffic to our containers"

  from_port         = 80
  protocol          = "tcp"
  to_port           = 80
  security_group_id = data.aws_security_group.nginx_auth_proxy_alb.id
  type              = "egress"

  source_security_group_id = data.aws_security_group.nginx_auth_proxy_ecs.id
}

resource "aws_security_group_rule" "allow_https_from_alb_to_containers" {
  description = "Allow HTTPS traffic to our containers"

  from_port         = 443
  protocol          = "tcp"
  to_port           = 443
  security_group_id = data.aws_security_group.nginx_auth_proxy_ecs.id
  type              = "ingress"

  source_security_group_id = data.aws_security_group.nginx_auth_proxy_alb.id
}

resource "aws_security_group_rule" "allow_http_from_alb_to_containers" {
  description = "Allow HTTPS traffic to our containers"

  from_port         = 80
  protocol          = "tcp"
  to_port           = 80
  security_group_id = data.aws_security_group.nginx_auth_proxy_ecs.id
  type              = "ingress"

  source_security_group_id = data.aws_security_group.nginx_auth_proxy_alb.id
}

resource "aws_security_group_rule" "allow_containers_all_outbound" {
  description = "Allow all outbound from containers to our VPC"

  from_port         = 0
  protocol          = -1
  to_port           = 0
  security_group_id = data.aws_security_group.nginx_auth_proxy_ecs.id
  type              = "egress"

  cidr_blocks = ["0.0.0.0/0"] # tfsec:ignore:AWS007
}

### User Service rules
resource "aws_security_group_rule" "allow_user_service_http_alb_ingress_from_auth_proxy" {
  description = "Allow the auth proxy http access to our alb"

  from_port = 80
  protocol  = "tcp"
  to_port   = 80
  type      = "ingress"

  security_group_id        = data.aws_security_group.user_service_alb.id
  source_security_group_id = data.aws_security_group.nginx_auth_proxy_ecs.id
}

resource "aws_security_group_rule" "allow_user_service_https_alb_ingress_from_auth_proxy" {
  description = "Allow the auth proxy https access to our alb"

  from_port = 443
  protocol  = "tcp"
  to_port   = 443
  type      = "ingress"

  security_group_id        = data.aws_security_group.user_service_alb.id
  source_security_group_id = data.aws_security_group.nginx_auth_proxy_ecs.id
}

resource "aws_security_group_rule" "allow_user_service_http_egress_to_auth_proxy" {
  description = "Allow all outbound HTTP traffic to our Auth Proxy"

  from_port = 80
  protocol  = "tcp"
  to_port   = 80
  type      = "egress"

  security_group_id        = data.aws_security_group.user_service_alb.id
  source_security_group_id = data.aws_security_group.nginx_auth_proxy_ecs.id
}

resource "aws_security_group_rule" "allow_user_service_https_egress_to_auth_proxy" {
  description = "Allow all outbound HTTPS traffic to our VPC"

  from_port = 443
  protocol  = "tcp"
  to_port   = 443
  type      = "egress"

  security_group_id        = data.aws_security_group.user_service_alb.id
  source_security_group_id = data.aws_security_group.nginx_auth_proxy_ecs.id
}

#### Application Rules
resource "aws_security_group_rule" "allow_bichard_http_alb_ingress_from_auth_proxy" {
  description = "Allow https access to the alb from the auth proxy"

  from_port = 80
  protocol  = "tcp"
  to_port   = 80
  type      = "ingress"

  security_group_id        = data.aws_security_group.bichard_alb.id
  source_security_group_id = data.aws_security_group.nginx_auth_proxy_ecs.id
}

resource "aws_security_group_rule" "allow_bichard_https_alb_ingress_from_auth_proxy" {
  description = "Allow https access to the alb from the auth proxy"

  from_port = 443
  protocol  = "tcp"
  to_port   = 443
  type      = "ingress"

  security_group_id        = data.aws_security_group.bichard_alb.id
  source_security_group_id = data.aws_security_group.nginx_auth_proxy_ecs.id
}

resource "aws_security_group_rule" "allow_bichard_https_egress_to_auth_proxy" {
  description = "Allow https access to the auth proxy from the alb"

  from_port = 443
  protocol  = "tcp"
  to_port   = 443
  type      = "egress"

  security_group_id        = data.aws_security_group.bichard_alb.id
  source_security_group_id = data.aws_security_group.nginx_auth_proxy_ecs.id
}

### Audit Logging Rules
resource "aws_security_group_rule" "allow_audit_logging_http_alb_ingress_from_auth_proxy" {
  description = "Allow http traffic from auth proxy to audit logging"

  from_port = 80
  protocol  = "tcp"
  to_port   = 80
  type      = "ingress"

  security_group_id        = data.aws_security_group.audit_logging_portal_alb.id
  source_security_group_id = data.aws_security_group.nginx_auth_proxy_ecs.id
}

resource "aws_security_group_rule" "allow_audit_logging_https_alb_ingress_from_auth_proxy" {
  description = "Allow https traffic from auth proxy to audit logging"

  from_port = 443
  protocol  = "tcp"
  to_port   = 443
  type      = "ingress"

  security_group_id        = data.aws_security_group.audit_logging_portal_alb.id
  source_security_group_id = data.aws_security_group.nginx_auth_proxy_ecs.id
}

resource "aws_security_group_rule" "allow_audit_logging_http_egress_to_auth_proxy" {
  description = "Allow http traffic from auth proxy to audit logging"

  from_port = 80
  protocol  = "tcp"
  to_port   = 80
  type      = "egress"

  security_group_id        = data.aws_security_group.audit_logging_portal_alb.id
  source_security_group_id = data.aws_security_group.nginx_auth_proxy_ecs.id
}

resource "aws_security_group_rule" "allow_audit_logging_https_egress_to_auth_proxy" {
  description = "Allow https traffic from auth proxy to audit logging"

  from_port = 443
  protocol  = "tcp"
  to_port   = 443
  type      = "egress"

  security_group_id        = data.aws_security_group.audit_logging_portal_alb.id
  source_security_group_id = data.aws_security_group.nginx_auth_proxy_ecs.id
}
