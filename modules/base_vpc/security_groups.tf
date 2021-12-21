resource "aws_security_group" "vpc_endpoints" {
  description = "${var.name_prefix} VPC Endpoint Security Group"

  name   = "${var.name_prefix}-vpc-endpoint"
  vpc_id = module.vpc.vpc_id

  tags = var.tags

  lifecycle {
    ignore_changes = [description]
  }
}

resource "aws_security_group_rule" "vpc_endpoints_ingress" {
  description = "Allow access to our vpce from the vpc"

  from_port         = 443
  protocol          = "tcp"
  security_group_id = aws_security_group.vpc_endpoints.id
  to_port           = 443
  type              = "ingress"

  cidr_blocks = module.vpc.private_subnets_cidr_blocks
}

resource "aws_security_group_rule" "vpc_endpoints_egress" {
  description = "Allow access from our vpce to the vpc"

  from_port         = 443
  protocol          = "tcp"
  security_group_id = aws_security_group.vpc_endpoints.id
  to_port           = 443
  type              = "egress"

  cidr_blocks = module.vpc.private_subnets_cidr_blocks
}
