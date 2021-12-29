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

variable "admin_allowed_cidr" {
  description = "A list of allowed subnet cidrs to access this resource"
  type        = list(string)
}

variable "logging_bucket_name" {
  description = "The default logging bucket for lb access logs"
  type        = string
}

variable "public_zone_id" {
  description = "The zone id for our public hosted zone so we can use ACM certificates"
  type        = string
}

variable "ssl_certificate_arn" {
  description = "The arn of our ssl certificate"
  type        = string
}

variable "audit_logging_portal_log_group" {
  description = "The log group we will be pushing our logs too"
  type        = any
}

variable "api_url" {
  description = "The url of our api lambda function"
  type        = string
}

variable "audit_logging_portal_ecs_image_url" {
  description = "Our image url to deploy"
  type        = string
}

variable "audit_logging_portal_ecs_image_hash" {
  description = "Our image hash to deploy"
  type        = string
}

variable "audit_logging_portal_ecs_arn" {
  description = "The arn of our audit logging portal"
  type        = string
}

variable "desired_instance_count" {
  description = "The number of containers we wish to provision"
  type        = number
  default     = 1
}

variable "override_deploy_tags" {
  description = "Required for CI/CD, do we want to allow us to overwrite the deploy tag"
  type        = bool
  default     = false
}

variable "audit_log_api_key_arn" {
  description = "The SSM ARN for the API key used to access the audit log API"
  type        = string
}
