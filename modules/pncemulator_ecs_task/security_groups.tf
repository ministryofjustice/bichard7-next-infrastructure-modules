resource "aws_security_group_rule" "nlb_utm_ingress_from_vpc" {
  description = "Allow UTM access from nlb to instances"

  from_port = 30001
  protocol  = "tcp"
  to_port   = 30001

  security_group_id = data.aws_security_group.pncemulator.id
  type              = "ingress"

  cidr_blocks = var.admin_allowed_cidr
}

resource "aws_security_group_rule" "nlb_api_ingress_from_vpc" {
  description = "Allow api access from nlb to instances"

  from_port = 3000
  protocol  = "tcp"
  to_port   = 3000

  security_group_id = data.aws_security_group.pncemulator.id
  type              = "ingress"

  cidr_blocks = var.admin_allowed_cidr
}

resource "aws_security_group_rule" "allow_all_outbound" {
  description = "Allow all outbound traffic to our VPC"

  from_port = 0
  protocol  = -1
  to_port   = 0

  security_group_id = data.aws_security_group.pncemulator.id
  type              = "egress"

  cidr_blocks = ["0.0.0.0/0"] #tfsec:ignore:AWS007
}
