resource "aws_security_group" "dns_endpoint" {
  description = "${var.name_prefix}-dns-endpoint Security Group"

  name   = "${var.name_prefix}-dns-endpoint"
  tags   = var.tags
  vpc_id = var.vpc_id

  lifecycle {
    ignore_changes = [description]
  }
}

resource "aws_security_group_rule" "dns_endpoint_tcp_ingress" {
  description = "Allow tcp dns queries"

  from_port         = 53
  protocol          = "TCP"
  to_port           = 53
  security_group_id = aws_security_group.dns_endpoint.id
  type              = "ingress"
  cidr_blocks       = var.allowed_subnet_cidr_blocks
}

resource "aws_security_group_rule" "dns_endpoint_udp_ingress" {
  description = "Allow upd dns queries"

  from_port         = 53
  protocol          = "UDP"
  to_port           = 53
  security_group_id = aws_security_group.dns_endpoint.id
  type              = "ingress"
  cidr_blocks       = var.allowed_subnet_cidr_blocks
}
