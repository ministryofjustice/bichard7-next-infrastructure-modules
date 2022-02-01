resource "aws_security_group_rule" "allow_all_outbound_http" {
  description = "Allow all outbound traffic to our VPC"

  from_port = 80
  protocol  = "tcp"
  to_port   = 80

  security_group_id = data.aws_security_group.audit_logging_portal_alb.id
  type              = "egress"

  cidr_blocks = var.admin_allowed_cidr
}

resource "aws_security_group_rule" "allow_all_outbound_https" {
  description = "Allow all outbound traffic to our VPC"

  from_port = 443
  protocol  = "tcp"
  to_port   = 443

  security_group_id = data.aws_security_group.audit_logging_portal_alb.id
  type              = "egress"

  cidr_blocks = var.admin_allowed_cidr
}

resource "aws_security_group_rule" "allow_alb_to_containers" {
  description = "Allow HTTP traffic to our container"

  from_port = 443
  protocol  = "tcp"
  to_port   = 443

  security_group_id = data.aws_security_group.audit_logging_portal_alb.id
  type              = "egress"

  source_security_group_id = data.aws_security_group.audit_logging_portal.id
}

resource "aws_security_group_rule" "allow_http_from_alb_to_containers" {
  description = "Allow HTTPS traffic to our container"

  from_port = 443
  protocol  = "tcp"
  to_port   = 443

  security_group_id = data.aws_security_group.audit_logging_portal.id
  type              = "ingress"

  source_security_group_id = data.aws_security_group.audit_logging_portal_alb.id
}

# tfsec:ignore:aws-vpc-no-public-egress-sgr
resource "aws_security_group_rule" "allow_containers_all_outbound" {
  description = "Allow all outbound traffic to our VPC"

  from_port = 0
  protocol  = -1
  to_port   = 0

  security_group_id = data.aws_security_group.audit_logging_portal.id
  type              = "egress"

  cidr_blocks = ["0.0.0.0/0"] #tfsec:ignore:AWS007
}
