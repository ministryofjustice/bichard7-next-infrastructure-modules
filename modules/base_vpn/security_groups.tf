resource "aws_security_group" "dns_endpoint" {
  description = "${var.name_prefix}-dns-endpoint Security Group"

  name   = "${var.name_prefix}-dns-endpoint"
  vpc_id = var.vpc_id

  lifecycle {
    ignore_changes = [description]
  }

  tags = var.tags
}

resource "aws_security_group_rule" "dns_endpoint_tcp_ingress" {
  description = "Allow tcp dns queries"

  from_port = 53
  to_port   = 53
  protocol  = "TCP"
  type      = "ingress"

  security_group_id = aws_security_group.dns_endpoint.id
  cidr_blocks       = var.allowed_subnet_cidr_blocks
}

resource "aws_security_group_rule" "dns_endpoint_udp_ingress" {
  description = "Allow upd dns queries"

  from_port = 53
  to_port   = 53
  protocol  = "UDP"
  type      = "ingress"

  security_group_id = aws_security_group.dns_endpoint.id
  cidr_blocks       = var.allowed_subnet_cidr_blocks
}
