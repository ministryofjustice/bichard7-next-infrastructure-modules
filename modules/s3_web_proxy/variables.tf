variable "name" {
  type        = string
  description = "The calling layers name"
}

variable "tags" {
  description = "A map of tags"
  type        = map(string)
  default     = {}
}

variable "fargate_cpu" {
  description = "The number of cpu units"
  type        = number
}

variable "fargate_memory" {
  description = "The amount of memory that will be given to fargate in Megabytes"
  type        = number
}

variable "vpc_id" {
  description = "The id of our vpc"
  type        = string
}

variable "service_subnets" {
  description = "A list of our subnet ids to attach the tasks onto"
  type        = list(string)
}

variable "logging_bucket_name" {
  description = "The default logging bucket for lb access logs"
  type        = string
}

variable "desired_instance_count" {
  description = "The number of instances we wish to deploy"
  type        = number
  default     = 1
}

variable "ssl_certificate_arn" {
  description = "The arn of our ssl certificate"
  type        = string
}

variable "public_zone_id" {
  description = "The public zone id that we will host against"
  type        = string
}

variable "bucket_name" {
  description = "The name of the bucket we need to connect to"
  type        = string
}

variable "service_id" {
  description = "The first part of the dns host name for this service"
  type        = string
}

variable "s3_web_proxy_image" {
  description = "The web proxy image to deploy"
  type        = string
}

variable "s3_web_proxy_arn" {
  description = "The arn for the web proxy ecr repository"
  type        = string
}

variable "parent_account_id" {
  description = "The id of the parent account"
  type        = string
}
