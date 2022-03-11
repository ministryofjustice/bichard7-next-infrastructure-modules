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

resource "aws_security_group_rule" "allow_egress_to_amq" {
  description = "Allow egress to amq from container"

  from_port = 61613
  protocol  = "tcp"
  to_port   = 61617
  type      = "egress"

  security_group_id        = data.aws_security_group.bichard_amq.id
  source_security_group_id = data.aws_security_group.bichard.id
}

resource "aws_security_group_rule" "allow_egress_to_aurora" {
  description = "Allow egress to amq from container"

  from_port = 5432
  protocol  = "tcp"
  to_port   = 5432
  type      = "egress"

  security_group_id        = data.aws_security_group.bichard_aurora.id
  source_security_group_id = data.aws_security_group.bichard.id
}

resource "aws_security_group_rule" "resource_to_s3_egress" {
  description = "Allow traffic from the resource to S3 needed to pull the image from ecr on container start"

  security_group_id = data.aws_security_group.bichard.id
  type              = "egress"
  protocol          = "tcp"
  from_port         = 443
  to_port           = 443

  prefix_list_ids = [var.vpc_endpoint_s3_prefix_list_id]
}

resource "aws_security_group_rule" "resource_to_beanconnect_egress" {
  description = "Allow traffic from the resource to beanconnect instance"

  security_group_id = data.aws_security_group.bichard.id
  type              = "egress"
  protocol          = "tcp"
  from_port         = 31004
  to_port           = 31004

  #tfsec:ignore:aws-vpc-no-public-ingress-sgr
  cidr_blocks = ["0.0.0.0/0"] #tfsec:ignore:AWS007
}
