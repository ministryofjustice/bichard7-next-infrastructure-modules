### VPC Endpoint
resource "aws_security_group" "postfix_vpce" {
  description = "Allow vpce traffic to/from postfix vpce"
  name        = "${var.name}-postfix-vpce"
  vpc_id      = module.postfix_vpc.vpc_id

  tags = merge(
    var.tags,
    {
      Name = "${var.name}-postfix-vpce"
    }
  )
}

resource "aws_security_group_rule" "allow_postfix_vpce_smtp_egress" {
  description = "Allow the proxy smtp egress to the vpc"

  from_port = 25
  to_port   = 25
  protocol  = "tcp"
  type      = "egress"

  security_group_id = aws_security_group.postfix_vpce.id
  cidr_blocks       = module.postfix_vpc.private_subnets_cidr_blocks
}

resource "aws_security_group_rule" "allow_postfix_vpce_smtps_egress" {
  description = "Allow the proxy smtps egress to vpc"

  from_port = 465
  to_port   = 465
  protocol  = "tcp"
  type      = "egress"

  security_group_id = aws_security_group.postfix_vpce.id
  cidr_blocks       = module.postfix_vpc.private_subnets_cidr_blocks
}

resource "aws_security_group_rule" "allow_smtp_ingress_from_the_application" {
  description = "Allow the application network ingress to the vpce"

  from_port = 2525
  to_port   = 2525
  protocol  = "tcp"
  type      = "ingress"

  security_group_id = aws_security_group.postfix_vpce.id
  cidr_blocks       = var.application_cidr
}

resource "aws_security_group_rule" "allow_smtps_ingress_from_the_application" {
  description = "Allow the application network ingress to the vpce"

  from_port = 4545
  to_port   = 4545
  protocol  = "tcp"
  type      = "ingress"

  security_group_id = aws_security_group.postfix_vpce.id
  cidr_blocks       = var.application_cidr
}

#postfix ecs cluster
resource "aws_security_group" "postfix_container" {
  description = "Postfix ECS container security group"
  name        = "${var.name}-postfix-container"
  vpc_id      = module.postfix_vpc.vpc_id

  tags = merge(
    var.tags,
    {
      Name = "${var.name}-postfix-container"
    }
  )
}

resource "aws_security_group_rule" "allow_smtps_ingress_from_vpc_to_postfix_container" {
  description       = "Allow postfix smtps access to postfix container"
  from_port         = 465
  protocol          = "tcp"
  to_port           = 465
  type              = "ingress"
  security_group_id = aws_security_group.postfix_container.id

  cidr_blocks = concat(
    module.postfix_vpc.private_subnets_cidr_blocks
  )
}

resource "aws_security_group_rule" "allow_smtp_ingress_from_vpc_to_postfix_container" {
  description       = "Allow postfix smtp access to postfix container"
  from_port         = 25
  protocol          = "tcp"
  to_port           = 25
  type              = "ingress"
  security_group_id = aws_security_group.postfix_container.id

  cidr_blocks = concat(
    module.postfix_vpc.private_subnets_cidr_blocks
  )
}

resource "aws_security_group_rule" "allow_smtps_from_container_to_cjsm_net" {
  description = "Allow SMTP Egress to CJSM"

  from_port = 4545
  to_port   = 4545
  protocol  = "tcp"
  type      = "egress"

  security_group_id = aws_security_group.postfix_container.id
  cidr_blocks = [
    local.cjsm_mail_server_address
  ]
}

resource "aws_security_group_rule" "allow_https_egress" {
  description = "All https egress from containers"

  from_port = 443
  to_port   = 443
  protocol  = "tcp"
  type      = "egress"

  security_group_id = aws_security_group.postfix_container.id
  cidr_blocks       = ["0.0.0.0/0"] # tfsec:ignore:AWS007
}
