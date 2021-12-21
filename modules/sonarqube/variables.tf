variable "environment" {
  type        = string
  description = "The target environment, will map to the terraform workspace"
}

variable "tags" {
  type        = map(string)
  description = "A map of environment tags"
  default     = {}
}

variable "fargate_cpu" {
  description = "The number of cpu units"
  type        = number
  default     = 1024
}

variable "fargate_memory" {
  description = "The amount of memory that will be given to fargate in Megabytes"
  type        = number
  default     = 2048
}

variable "name" {
  description = "The deployments name"
  type        = string
}

variable "logging_bucket_name" {
  description = "The default logging bucket for lb access logs"
  type        = string
}

variable "server_certificate_arn" {
  description = "The arn of our server certificate"
  type        = string
}
