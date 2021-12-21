variable "name" {
  description = "The name used for our naming prefix"
  type        = string
}

variable "vpc_id" {
  description = "The id of our VPC"
  type        = string
}

variable "tags" {
  description = "A map of tags for our resource"
  type        = map(string)
}

variable "admin_allowed_cidr" {
  description = "A list of cidrs that are allowed access"
  type        = list(string)
}

variable "service_subnets" {
  description = "A list of allowed subnets"
  type        = list(string)
}

variable "instance_type" {
  description = "The elasticsearch instance type we want to use"
  type        = string
  default     = "r5.xlarge.elasticsearch"
}

variable "ebs_volume_size" {
  description = "The size of our ebs instances"
  type        = number
  default     = 1500
}

variable "elasticsearch_log_groups" {
  description = "The log groups we are going to consume in elastic search"
  type        = map(any)
}

variable "elasticsearch_log_group" {
  description = "Our elasticsearch log group"
  type        = any
}

variable "public_zone_name" {
  description = "The public zone name for our friendly url"
  type        = string
}

variable "public_zone_id" {
  description = "The public zone id"
  type        = string
}

variable "server_certificate_arn" {
  description = "The arn of our public ssl certificate"
  type        = string
}
