resource "aws_security_group_rule" "allow_alb_to_containers" {
  description = "Allow HTTP traffic to our containers"

  from_port         = 443
  protocol          = "tcp"
  to_port           = 443
  security_group_id = data.aws_security_group.user_service_alb.id
  type              = "egress"

  source_security_group_id = data.aws_security_group.user_service_ecs.id
}

resource "aws_security_group_rule" "allow_http_from_alb_to_containers" {
  description = "Allow HTTPS traffic to our containers"

  from_port         = 443
  protocol          = "tcp"
  to_port           = 443
  security_group_id = data.aws_security_group.user_service_ecs.id
  type              = "ingress"

  source_security_group_id = data.aws_security_group.user_service_alb.id
}

resource "aws_security_group_rule" "allow_containers_all_outbound" {
  description = "Allow all outbound from containers to our VPC"

  from_port         = 0
  protocol          = -1
  to_port           = 0
  security_group_id = data.aws_security_group.user_service_ecs.id
  type              = "egress"

  cidr_blocks = ["0.0.0.0/0"] # tfsec:ignore:AWS007
}
