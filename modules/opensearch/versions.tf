terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "= 3.56.0"
    }
    time = {
      source  = "hashicorp/time"
      version = "0.7.2"
    }
    archive = {
      source  = "hashicorp/archive"
      version = "= 2.0.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "= 3.0.1"
    }
    elasticsearch = {
      source  = "phillbaker/elasticsearch"
      version = "= 2.0.0-beta.2"
    }
  }
  required_version = ">= 0.13"
}
