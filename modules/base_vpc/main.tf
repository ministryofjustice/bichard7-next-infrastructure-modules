module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "3.0.0"

  manage_default_vpc = false

  name = var.name_prefix
  cidr = var.cidr_block

  enable_dns_hostnames = true
  enable_dns_support   = true

  default_security_group_egress  = []
  default_security_group_ingress = []
  manage_default_security_group  = false
  default_security_group_tags    = var.tags
  default_security_group_name    = "${var.name_prefix}-default-security-group"

  azs = [
    "${var.region_id}a",
    "${var.region_id}b",
    "${var.region_id}c"
  ]

  create_database_subnet_group = false

  private_subnets = [
    cidrsubnet(var.cidr_block, 8, 1),
    cidrsubnet(var.cidr_block, 8, 2),
    cidrsubnet(var.cidr_block, 8, 3)
  ]

  map_public_ip_on_launch = false

  tags = local.tags_without_name
}

module "vpc_endpoints" {
  source  = "terraform-aws-modules/vpc/aws//modules/vpc-endpoints"
  version = "3.0.0"

  security_group_ids = [aws_security_group.vpc_endpoints.id]
  subnet_ids         = module.vpc.private_subnets
  endpoints = {
    states = {
      service             = "states"
      private_dns_enabled = true
      subnet_ids          = module.vpc.private_subnets
      tags = {
        Name = "${var.tags["Name"]}-states"
      }
    },
    s3 = {
      service = "s3"
      tags = {
        Name = "${var.tags["Name"]}-s3-interface"
      }
    },
    s3g = {
      service         = "s3"
      service_type    = "Gateway"
      route_table_ids = flatten([module.vpc.private_route_table_ids])
      tags = {
        Name = "${var.tags["Name"]}-s3-gateway"
      }
    },
    dynamodb = {
      service         = "dynamodb"
      service_type    = "Gateway"
      route_table_ids = flatten([module.vpc.private_route_table_ids])
      tags = {
        Name = "${var.tags["Name"]}-dynamodb"
      }
    },
    ssm = {
      service             = "ssm"
      private_dns_enabled = true
      subnet_ids          = module.vpc.private_subnets
      tags = {
        Name = "${var.tags["Name"]}-ssm"
      }
    },
    sns = {
      service             = "sns"
      private_dns_enabled = true
      subnet_ids          = module.vpc.private_subnets
      tags = {
        Name = "${var.tags["Name"]}-sns"
      }
    },
    ssmmessages = {
      service             = "ssmmessages"
      private_dns_enabled = true
      subnet_ids          = module.vpc.private_subnets
      tags = {
        Name = "${var.tags["Name"]}-ssmmessages"
      }
    },
    sts = {
      service             = "sts"
      private_dns_enabled = true
      subnet_ids          = module.vpc.private_subnets
      tags = {
        Name = "${var.tags["Name"]}-sts"
      }
    },
    secretsmanager = {
      service             = "secretsmanager"
      private_dns_enabled = true
      subnet_ids          = module.vpc.private_subnets
      tags = {
        Name = "${var.tags["Name"]}-secretsmanager"
      }
    },
    lambda = {
      service             = "lambda"
      private_dns_enabled = true
      subnet_ids          = module.vpc.private_subnets
      tags = {
        Name = "${var.tags["Name"]}-lambda"
      }
    },
    ecs = {
      service             = "ecs"
      private_dns_enabled = true
      subnet_ids          = module.vpc.private_subnets
      tags = {
        Name = "${var.tags["Name"]}-ecs"
      }
    },
    ecs_telemetry = {
      service             = "ecs-telemetry"
      private_dns_enabled = true
      subnet_ids          = module.vpc.private_subnets
      tags = {
        Name = "${var.tags["Name"]}-ecs-telemetry"
      }
    },
    ecs_agent = {
      service             = "ecs-agent"
      private_dns_enabled = true
      subnet_ids          = module.vpc.private_subnets
      tags = {
        Name = "${var.tags["Name"]}-ecs-agent"
      }
    },
    monitoring = {
      service             = "monitoring"
      private_dns_enabled = true
      subnet_ids          = module.vpc.private_subnets
      tags = {
        Name = "${var.tags["Name"]}-monitoring"
      }
    },
    logs = {
      service             = "logs"
      private_dns_enabled = true
      subnet_ids          = module.vpc.private_subnets
      tags = {
        Name = "${var.tags["Name"]}-logs"
      }
    },
    elasticfilesystem = {
      service             = "elasticfilesystem"
      private_dns_enabled = true
      subnet_ids          = module.vpc.private_subnets
      tags = {
        Name = "${var.tags["Name"]}-elasticfilesystem"
      }
    },
    ec2 = {
      service             = "ec2"
      private_dns_enabled = true
      subnet_ids          = module.vpc.private_subnets
      tags = {
        Name = "${var.tags["Name"]}-ec2"
      }
    },
    ec2messages = {
      service             = "ec2messages"
      private_dns_enabled = true
      subnet_ids          = module.vpc.private_subnets
      tags = {
        Name = "${var.tags["Name"]}-ec2messages"
      }
    },
    ecr_api = {
      service             = "ecr.api"
      private_dns_enabled = true
      subnet_ids          = module.vpc.private_subnets
      tags = {
        Name = "${var.tags["Name"]}-ecr-api"
      }
    },
    ecr_dkr = {
      service             = "ecr.dkr"
      private_dns_enabled = true
      subnet_ids          = module.vpc.private_subnets
      security_group_ids  = [aws_security_group.vpc_endpoints.id]
      tags = {
        Name = "${var.tags["Name"]}-ecr-dkr"
      }
    },
    kms = {
      service             = "kms"
      private_dns_enabled = true
      subnet_ids          = module.vpc.private_subnets
      security_group_ids  = [aws_security_group.vpc_endpoints.id]
      tags = {
        Name = "${var.tags["Name"]}-kms"
      }
    },
    execute_api = {
      service             = "execute-api"
      private_dns_enabled = true
      subnet_ids          = module.vpc.private_subnets
      security_group_ids  = [aws_security_group.vpc_endpoints.id]
      tags = {
        Name = "${var.tags["Name"]}-execute-api"
      }
    },
  }

  tags = var.tags

  vpc_id = module.vpc.vpc_id
}
