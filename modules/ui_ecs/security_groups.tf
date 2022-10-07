resource "aws_security_group_rule" "allow_alb_to_containers" {
  description = "Allow HTTPS traffic out of our containers"

  from_port         = 443
  protocol          = "tcp"
  to_port           = 443
  security_group_id = data.aws_security_group.ui_alb.id
  type              = "egress"

  source_security_group_id = data.aws_security_group.ui_ecs.id
}

resource "aws_security_group_rule" "allow_https_from_alb_into_containers" {
  description = "Allow HTTPS traffic to our containers"

  from_port         = 443
  protocol          = "tcp"
  to_port           = 443
  security_group_id = data.aws_security_group.ui_ecs.id
  type              = "ingress"

  source_security_group_id = data.aws_security_group.ui_alb.id
}

resource "aws_security_group_rule" "allow_ecs_to_alb" {
  description = "Allow HTTPS traffic out to our alb"

  from_port         = 443
  protocol          = "tcp"
  to_port           = 443
  security_group_id = data.aws_security_group.ui_ecs.id
  type              = "egress"

  source_security_group_id = data.aws_security_group.ui_alb.id
}

resource "aws_security_group_rule" "allow_https_from_ecs_into_alb" {
  description = "Allow HTTPS traffic to our containers"

  from_port         = 443
  protocol          = "tcp"
  to_port           = 443
  security_group_id = data.aws_security_group.ui_alb.id
  type              = "ingress"

  source_security_group_id = data.aws_security_group.ui_ecs.id
}

resource "aws_security_group_rule" "allow_containers_s3_outbound" {
  description = "Allow s3 outbound from containers to our VPC, needed to pull from ecr"

  from_port         = 443
  protocol          = "tcp"
  to_port           = 443
  security_group_id = data.aws_security_group.ui_ecs.id
  type              = "egress"

  prefix_list_ids = [data.aws_ec2_managed_prefix_list.s3.id]
}

resource "aws_security_group_rule" "allow_egress_to_db" {
  description = "Allow egress to db from container"

  from_port = 5432
  protocol  = "tcp"
  to_port   = 5432
  type      = "egress"

  security_group_id        = data.aws_security_group.ui_ecs.id
  source_security_group_id = data.aws_security_group.bichard_aurora.id
}

resource "aws_security_group_rule" "allow_egress_to_amq" {
  description = "Allow egress to amq from container"

  from_port = 61613
  protocol  = "tcp"
  to_port   = 61617
  type      = "egress"

  security_group_id        = data.aws_security_group.ui_ecs.id
  source_security_group_id = data.aws_security_group.bichard_amq.id
}

resource "aws_security_group_rule" "vpc_endpoints_from_es_egress" {
  description = "Allow egress to vpc endpoints"

  from_port = 443
  protocol  = "tcp"
  to_port   = 443
  type      = "egress"

  security_group_id        = data.aws_security_group.ui_ecs.id
  source_security_group_id = data.terraform_remote_state.base_infra.outputs.vpc.security_group_ids.vpc_endpoints
}
