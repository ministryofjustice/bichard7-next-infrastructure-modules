module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "2.78.0"

  name = "sonar-vpc"
  cidr = "10.1.0.0/16"

  azs              = ["eu-west-2a", "eu-west-2b", "eu-west-2c"]
  private_subnets  = ["10.1.1.0/24", "10.1.2.0/24", "10.1.3.0/24"]
  public_subnets   = ["10.1.4.0/24", "10.1.5.0/24", "10.1.6.0/24"]
  database_subnets = ["10.1.7.0/24", "10.1.8.0/24", "10.1.9.0/24"]

  enable_nat_gateway           = true
  enable_vpn_gateway           = true
  enable_dns_support           = true
  enable_dns_hostnames         = true
  create_database_subnet_group = true

  tags = var.tags
}
