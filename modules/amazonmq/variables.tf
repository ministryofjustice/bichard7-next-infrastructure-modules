variable "tags" {
  description = "The tags for the resources"
  type        = map(string)
}

variable "environment_name" {
  description = "The name of the environment"
  type        = string
}

variable "vpc_id" {
  description = "The ID of the VPC that the RDS cluster will be created in"
  type        = string
}

variable "private_subnet_ids" {
  description = "The ID's of the VPC subnets that the RDS cluster instances will be created in"
  type        = list(string)
}

variable "allowed_cidrs" {
  description = "The CIDR blocks allowed to connect to Amazon MQ"
  type        = list(string)
}

variable "amq_master_username" {
  description = "The master username for the rds instance"
  type        = string
}

variable "private_zone_id" {
  description = "The private hosted zone"
  type        = string
}

variable "broker_instance_type" {
  description = "The instance type we want to use for our broker"
  type        = string
  default     = "mq.t2.micro"
}
