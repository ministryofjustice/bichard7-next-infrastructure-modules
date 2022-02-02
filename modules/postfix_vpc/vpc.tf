resource "aws_eip" "nat_gateway_static_ip" {
  vpc = true

  tags = merge(
    var.tags,
    {
      name = "${var.name}-postfix-nat-eip"
    }
  )
}

module "postfix_vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "3.0.0"

  name = "${var.name}-postfix-vpc"
  cidr = local.cidr_block

  azs = [
    "eu-west-2a",
    "eu-west-2b",
    "eu-west-2c"
  ]
  private_subnets = slice(local.cidr_sub_blocks, 0, 3)
  public_subnets  = slice(local.cidr_sub_blocks, 3, 6)

  enable_nat_gateway   = true
  single_nat_gateway   = true
  external_nat_ip_ids  = [aws_eip.nat_gateway_static_ip.id]
  enable_vpn_gateway   = false
  create_igw           = true
  enable_dns_hostnames = true
  enable_dns_support   = true

  enable_flow_log           = true
  flow_log_destination_type = "s3"
  flow_log_destination_arn  = aws_s3_bucket.vpc_flow_logs_bucket.arn
  vpc_flow_log_tags = merge(
    var.tags,
    {
      name = "${var.name}-postfix-flow-logs"
    }
  )

  manage_default_security_group = true
  default_security_group_tags = merge(
    var.tags,
    {
      name = "${var.name}-postfix-sg"
    }
  )
  default_security_group_egress  = []
  default_security_group_ingress = []

  vpc_tags = merge(
    var.tags,
    {
      name = "${var.name}-postfix-vpc"
    }
  )

  tags = var.tags
}

resource "aws_security_group" "postfix_vpc_sg" {
  name        = "${var.name}-postfix-vpc-sg"
  description = "SG for our Postfix VPC"

  vpc_id = module.postfix_vpc.vpc_id

  tags = merge(
    var.tags,
    {
      name = "${var.name}-postfix-vpc"
    }
  )
}

resource "aws_security_group_rule" "allow_vpc_endpoint_smtp_ingress" {
  description = "Allow SMTP ingress from our VPC Endpoint"

  from_port = 25
  to_port   = 25
  protocol  = "tcp"
  type      = "ingress"

  security_group_id = aws_security_group.postfix_vpc_sg.id
  cidr_blocks       = var.ingress_cidr_blocks
}

resource "aws_security_group_rule" "allow_vpc_endpoint_secure_smtp_ingress" {
  description = "Allow Secure SMTP ingress from our VPC Endpoint"

  from_port = 465
  to_port   = 465
  protocol  = "tcp"
  type      = "ingress"

  security_group_id = aws_security_group.postfix_vpc_sg.id
  cidr_blocks       = var.ingress_cidr_blocks
}
