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

## Lambda Security Groups
resource "aws_security_group_rule" "snapshot_lambda_egress" {
  description = "Allow https traffic from the lambda to our es cluster"

  from_port = 443
  to_port   = 443
  protocol  = "tcp"
  type      = "egress"

  security_group_id        = data.aws_security_group.snapshot_lambda.id
  source_security_group_id = data.aws_security_group.es.id
}

resource "aws_security_group_rule" "snapshot_lambda_ingress" {
  description = "Allow https traffic to the lambda from our es cluster"

  from_port = 443
  to_port   = 443
  protocol  = "tcp"
  type      = "ingress"

  security_group_id        = data.aws_security_group.es.id
  source_security_group_id = data.aws_security_group.snapshot_lambda.id
}

resource "aws_security_group_rule" "allow_secret_rotation_lambda_ingress_from_endpoint" {
  description = "Allow traffic from our VPCE into secrets rotation lambda"

  from_port = 443
  to_port   = 443
  protocol  = "tcp"
  type      = "ingress"

  security_group_id        = data.aws_security_group.lambda_egress_to_secretsmanager_vpce.id
  source_security_group_id = data.aws_security_group.secretsmanager_vpce.id
}

resource "aws_security_group_rule" "allow_secret_rotation_lambda_egress_to_endpoint" {
  description = "Allow traffic from secrets rotation lambda out to VPCE"

  from_port = 443
  to_port   = 443
  protocol  = "tcp"
  type      = "egress"

  security_group_id        = data.aws_security_group.secretsmanager_vpce.id
  source_security_group_id = data.aws_security_group.lambda_egress_to_secretsmanager_vpce.id
}
