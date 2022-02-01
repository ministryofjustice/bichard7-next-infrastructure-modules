resource "aws_security_group_rule" "allow_nlb_from_vpc" {
  description = "Allow access from nlb to instances"

  from_port         = 31004
  protocol          = "tcp"
  security_group_id = data.aws_security_group.beanconnect.id
  to_port           = 31004
  type              = "ingress"

  cidr_blocks = var.admin_allowed_cidr
}

# tfsec:ignore:aws-vpc-no-public-egress-sgr
resource "aws_security_group_rule" "allow_all_outbound" {
  description = "Allow all outbound traffic to our VPC"

  from_port = 0
  protocol  = -1
  to_port   = 0

  security_group_id = data.aws_security_group.beanconnect.id
  type              = "egress"

  cidr_blocks = ["0.0.0.0/0"] #tfsec:ignore:AWS007
}

resource "aws_security_group_rule" "was_egress_to_beanconnect" {
  description = "Allow was to send messages to the beanconnect proxy"

  from_port = "31004"
  to_port   = "31004"
  protocol  = "tcp"

  security_group_id = data.aws_security_group.bichard7.id
  type              = "egress"

  source_security_group_id = data.aws_security_group.beanconnect.id
}

resource "aws_security_group_rule" "beanconnect_ingress_from_bichard7" {
  description = "Allow the beanconnect proxy to receive messages from Bichard7"

  from_port = "31004"
  to_port   = "31004"
  protocol  = "tcp"

  source_security_group_id = data.aws_security_group.bichard7.id
  type                     = "ingress"

  security_group_id = data.aws_security_group.beanconnect.id
}
