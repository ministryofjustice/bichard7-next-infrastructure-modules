resource "aws_security_group_rule" "elasticsearch_ingress_from_vpc" {
  description = "Allow access to inside the vpc"

  protocol  = "tcp"
  from_port = 443
  to_port   = 443

  security_group_id = data.aws_security_group.es.id
  type              = "ingress"

  cidr_blocks = var.admin_allowed_cidr
}

resource "aws_security_group_rule" "elasticsearch_egress_to_vpc" {
  description = "Allow access to inside the vpc"

  protocol  = "tcp"
  from_port = 443
  to_port   = 443

  security_group_id = data.aws_security_group.es.id
  type              = "egress"

  cidr_blocks = var.admin_allowed_cidr

}
