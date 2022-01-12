### Postfix
resource "aws_security_group" "postfix_instance" {
  name        = "${var.name}-postfix"
  description = "All postfix instance traffic"
  vpc_id      = module.postfix_vpc.vpc_id

  tags = var.tags
}

resource "aws_security_group_rule" "allow_https_egress" {
  description = "All https egress from instance"

  from_port = 443
  to_port   = 443
  protocol  = "tcp"
  type      = "egress"

  security_group_id = aws_security_group.postfix_instance.id
  cidr_blocks       = ["0.0.0.0/0"] # tfsec:ignore:AWS007
}

resource "aws_security_group_rule" "allow_smtp_to_cjsm_net" {
  description = "Allow SMTP Egress to CJSM"

  from_port = 25
  to_port   = 25
  protocol  = "tcp"
  type      = "egress"

  security_group_id = aws_security_group.postfix_instance.id
  cidr_blocks = [
    local.cjsm_mail_server_address
  ]
}

resource "aws_security_group_rule" "allow_smtp_alternate_port_to_cjsm_net" {
  description = "Allow SMTP Egress to CJSM"

  from_port = 4545
  to_port   = 4545
  protocol  = "tcp"
  type      = "egress"

  security_group_id = aws_security_group.postfix_instance.id
  cidr_blocks = [
    local.cjsm_mail_server_address
  ]
}

resource "aws_security_group_rule" "allow_ssh_ingress_from_bastion" {
  description = "All ssh ingress from bastion to instance"

  from_port = 22
  to_port   = 22
  protocol  = "tcp"
  type      = "ingress"

  security_group_id        = aws_security_group.postfix_instance.id
  source_security_group_id = aws_security_group.bastion.id
}

resource "aws_security_group_rule" "allow_smtp_to_instance_from_private_subnets" {
  description = "Allow SMTP ingress from Private Subnets"

  from_port = 25
  to_port   = 25
  protocol  = "tcp"
  type      = "ingress"

  security_group_id = aws_security_group.postfix_instance.id
  cidr_blocks = concat(
    module.postfix_vpc.private_subnets_cidr_blocks
  )
}

resource "aws_security_group_rule" "allow_smtps_to_instance_from_private_subnets" {
  description = "Allow SMTPS ingress from Private Subnets"

  from_port = 465
  to_port   = 465
  protocol  = "tcp"
  type      = "ingress"

  security_group_id = aws_security_group.postfix_instance.id
  cidr_blocks = concat(
    module.postfix_vpc.private_subnets_cidr_blocks
  )
}

resource "aws_security_group_rule" "allow_prometheus_node_exporter_to_instance_from_private_subnets" {
  description = "Allow Prometheus Node Exporter ingress from Private Subnets"

  from_port = 9100
  to_port   = 9100
  protocol  = "tcp"
  type      = "ingress"

  security_group_id = aws_security_group.postfix_instance.id
  cidr_blocks = concat(
    module.postfix_vpc.private_subnets_cidr_blocks
  )
}

resource "aws_security_group_rule" "allow_prometheus_postfix_exporter_to_instance_from_private_subnets" {
  description = "Allow Prometheus Postfix Exporter ingress from Private Subnets"

  from_port = 9154
  to_port   = 9154
  protocol  = "tcp"
  type      = "ingress"

  security_group_id = aws_security_group.postfix_instance.id
  cidr_blocks = concat(
    module.postfix_vpc.private_subnets_cidr_blocks
  )
}

resource "aws_security_group_rule" "allow_smtp_to_instance_from_vpce" {
  description = "Allow SMTP ingress from Private Subnets"

  from_port = 25
  to_port   = 25
  protocol  = "tcp"
  type      = "ingress"

  security_group_id        = aws_security_group.postfix_instance.id
  source_security_group_id = aws_security_group.postfix_vpce.id
}

resource "aws_security_group_rule" "allow_smtps_to_instance_from_vpce" {
  description = "Allow SMTPS ingress from Private Subnets"

  from_port = 465
  to_port   = 465
  protocol  = "tcp"
  type      = "ingress"

  security_group_id        = aws_security_group.postfix_instance.id
  source_security_group_id = aws_security_group.postfix_vpce.id
}

resource "aws_security_group_rule" "allow_node_exporter_to_instance_from_vpce" {
  description = "Allow Prometheus Node Exporter ingress from Private Subnets"

  from_port = 9100
  to_port   = 9100
  protocol  = "tcp"
  type      = "ingress"

  security_group_id        = aws_security_group.postfix_instance.id
  source_security_group_id = aws_security_group.postfix_vpce.id
}

## Bastion
resource "aws_security_group" "bastion" {
  name        = "${var.name}-bastion"
  description = "All bastion instance traffic"
  vpc_id      = module.postfix_vpc.vpc_id

  tags = var.tags
}

resource "aws_security_group_rule" "allow_ssh_ingress_from_world_bastion_instance" {
  description = "Allow ssh ingress from world to instances"

  from_port = 2222
  to_port   = 2222
  protocol  = "tcp"
  type      = "ingress"

  security_group_id = aws_security_group.bastion.id
  cidr_blocks       = ["0.0.0.0/0"] # tfsec:ignore:AWS006
}

resource "aws_security_group_rule" "allow_ssh_from_bastion_to_private_vpc" {
  description = "Allow ssh egress to our private vpc cidrs"

  from_port = 22
  to_port   = 22
  protocol  = "tcp"
  type      = "egress"

  security_group_id = aws_security_group.bastion.id
  cidr_blocks       = module.postfix_vpc.private_subnets_cidr_blocks
}

resource "aws_security_group_rule" "allow_https_from_bastion" {
  description = "Allow Bastion https access out so we can pull SSM"

  from_port = 443
  to_port   = 443
  protocol  = "tcp"
  type      = "egress"

  security_group_id = aws_security_group.bastion.id
  cidr_blocks       = ["0.0.0.0/0"] # tfsec:ignore:AWS007
}


### VPC Endpoint
resource "aws_security_group" "postfix_vpce" {
  description = "Allow vpce traffic to/from postfix vpce"
  name        = "${var.name}-postfix-vpce"
  vpc_id      = module.postfix_vpc.vpc_id

  tags = var.tags
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

resource "aws_security_group_rule" "allow_node_exporter_ingress_from_the_application" {
  description = "Allow the application network ingress to the vpce"

  from_port = 9100
  to_port   = 9100
  protocol  = "tcp"
  type      = "ingress"

  security_group_id = aws_security_group.postfix_vpce.id
  cidr_blocks       = var.application_cidr
}

resource "aws_security_group_rule" "allow_postfix_exporter_ingress_from_the_application" {
  description = "Allow the application network ingress to the vpce"

  from_port = 9154
  to_port   = 9154
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
