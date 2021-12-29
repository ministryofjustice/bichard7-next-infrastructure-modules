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

variable "beanconnect_ecs_image_url" {
  description = "The url and sha256 hash of our beanconnect image"
  type        = string
}

variable "beanconnect_ecs_image_hash" {
  description = "The hash of our beanconnect image"
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

variable "beanconnect_repo_arn" {
  type = string
}

variable "private_zone_id" {
  description = "The private hosted zone"
  type        = string
}

variable "beanconnect_log_group" {
  description = "The log group we will be pushing our logs too"
  type        = any
}

variable "using_pnc_emulator" {
  description = "Is this stack using a pnc emulator"
  type        = bool
  default     = false
}

## PNC Config settings, if omitted will default
variable "pnc_lpap" {
  description = "The name of the PNC LPAP connection"
  type        = string
  default     = null
}

variable "pnc_aeq" {
  description = "The application entity qualifier"
  type        = string
  default     = null
}

variable "pnc_contwin" {
  description = "The number of contention winners"
  type        = string
  default     = null
}

variable "pnc_proxy_hostname" {
  description = "The proxy hostname for BeanConnect"
  type        = string
  default     = null
}
