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

variable "pncemulator_ecs_image_url" {
  description = "The url and sha256 hash of our pncemulator image"
  type        = string
}

variable "desired_instance_count" {
  description = "The number of instances we wish to deploy"
  type        = number
  default     = null
}

variable "parent_account_id" {
  description = "Our Parent Account ID"
  type        = string
}

variable "pncemulator_repo_arn" {
  description = "The arn of the pnc emulator"
  type        = string
}

variable "pncemulator_log_group" {
  description = "The log group for our pnc emulator"
  type        = any
}
