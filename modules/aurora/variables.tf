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

variable "rds_master_username" {
  description = "The master username for the rds instance"
  type        = string
}

variable "rds_database_name" {
  description = "The name of the database"
  type        = string
}

variable "rds_engine" {
  description = "The aurora database engine to use"
  type        = string
}

variable "rds_engine_version" {
  description = "The aurora database engine version to use"
  type        = string
}

variable "private_zone_id" {
  description = "The private hosted zone"
  type        = string
}

variable "db_instance_class" {
  description = "What instances do we want to deploy for our db cluster"
  type        = string
  default     = "db.t3.medium"
}
