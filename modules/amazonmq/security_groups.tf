resource "aws_security_group_rule" "amq_allow_all_egress_to_was_web" {
  description = "Allow message queue to access WAS"

  from_port = 0
  to_port   = 0
  protocol  = "all"

  security_group_id = data.aws_security_group.amq.id
  type              = "egress"

  source_security_group_id = data.aws_security_group.bichard7_web.id
}

resource "aws_security_group_rule" "amq_allow_all_egress_to_was_backend" {
  description = "Allow message queue to access WAS"

  from_port = 0
  to_port   = 0
  protocol  = "all"

  security_group_id = data.aws_security_group.amq.id
  type              = "egress"

  source_security_group_id = data.aws_security_group.bichard7_backend.id
}

resource "aws_security_group_rule" "was_web_ingress_to_amq_openwire" {
  description = "Allow message queue access via openwire from WAS"

  from_port = 61617
  to_port   = 61617
  protocol  = "tcp"

  security_group_id = data.aws_security_group.amq.id
  type              = "ingress"

  source_security_group_id = data.aws_security_group.bichard7_web.id
}

resource "aws_security_group_rule" "was_backend_ingress_to_amq_openwire" {
  description = "Allow message queue access via openwire from WAS"

  from_port = 61617
  to_port   = 61617
  protocol  = "tcp"

  security_group_id = data.aws_security_group.amq.id
  type              = "ingress"

  source_security_group_id = data.aws_security_group.bichard7_backend.id
}

resource "aws_security_group_rule" "was_web_ingress_to_amq_stomp" {
  description = "Allow message queue access via stomp+ssl from WAS"

  from_port = 61614
  to_port   = 61614
  protocol  = "tcp"

  security_group_id = data.aws_security_group.amq.id
  type              = "ingress"

  source_security_group_id = data.aws_security_group.bichard7_web.id
}

resource "aws_security_group_rule" "was_ui_ingress_to_amq_stomp" {
  description = "Allow message queue access via stomp+ssl from WAS"

  from_port = 61613
  to_port   = 61617
  protocol  = "tcp"

  security_group_id = data.aws_security_group.amq.id
  type              = "ingress"

  source_security_group_id = data.aws_security_group.bichard7_ui.id
}

resource "aws_security_group_rule" "was_backendingress_to_amq_stomp" {
  description = "Allow message queue access via stomp+ssl from WAS"

  from_port = 61614
  to_port   = 61614
  protocol  = "tcp"

  security_group_id = data.aws_security_group.amq.id
  type              = "ingress"

  source_security_group_id = data.aws_security_group.bichard7_backend.id
}

resource "aws_security_group_rule" "amq_allow_queue_vpc_ingress_openwire" {
  description = "Allow message queue access (OpenWire) from VPC"
  from_port   = 61617
  protocol    = "tcp"
  to_port     = 61617
  type        = "ingress"

  security_group_id = data.aws_security_group.amq.id
  cidr_blocks       = var.allowed_cidrs

}

resource "aws_security_group_rule" "amq_allow_queue_vpc_ingress_stomp" {
  description = "Allow message queue access (STOMP) from VPC"
  from_port   = 61614
  protocol    = "tcp"
  to_port     = 61614
  type        = "ingress"

  security_group_id = data.aws_security_group.amq.id
  cidr_blocks       = var.allowed_cidrs

}

resource "aws_security_group_rule" "amq_allow_egress" {
  description = "Allow message queue to access all in vpc"

  from_port = 0
  protocol  = "all"
  to_port   = 0
  type      = "egress"

  security_group_id = data.aws_security_group.amq.id
  cidr_blocks       = var.allowed_cidrs
}
