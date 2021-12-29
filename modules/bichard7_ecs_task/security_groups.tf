resource "aws_security_group_rule" "alb_default_https_access_from_alb" {
  description = "Allow access on http transport port from alb"

  from_port = 9443
  protocol  = "tcp"
  to_port   = 9443
  type      = "ingress"

  security_group_id        = data.aws_security_group.bichard.id
  source_security_group_id = data.aws_security_group.bichard_alb.id
}

resource "aws_security_group_rule" "alb_allow_egress_to_instance" {
  description = "Allow access on http transport port from alb"

  from_port = 9443
  protocol  = "tcp"
  to_port   = 9443
  type      = "egress"

  security_group_id        = data.aws_security_group.bichard_alb.id
  source_security_group_id = data.aws_security_group.bichard.id
}


resource "aws_security_group_rule" "allow_all_outbound" {
  description = "Allow all outbound traffic to our VPC"

  from_port = 0
  protocol  = -1
  to_port   = 0
  type      = "egress"

  security_group_id = data.aws_security_group.bichard.id
  cidr_blocks       = ["0.0.0.0/0"] #tfsec:ignore:AWS007
}
