terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "= 3.75.2"
    }
    random = {
      source  = "hashicorp/random"
      version = "= 3.0.1"
    }
  }
  required_version = ">= 0.13"
}
