variable "name" {
  description = "The name to be associated with the ECS cluster resources"
  type        = string
}

variable "tags" {
  description = "A map of tags used in ecs"
  type        = map(string)
}

variable "service_subnets" {
  description = "A list of subnets used by ECS"
  type        = list(string)
}

variable "vpc_id" {
  description = "The vpc id"
  type        = string
}

variable "admin_allowed_cidr" {
  description = "A list of cidrs allowed to access ECS"
  type        = list(string)
}

variable "bichard_deploy_tag" {
  description = "The tag of the bichard7 application image to deploy"
  type        = string
}

variable "override_deploy_tags" {
  description = "Required for CI/CD, do we want to allow us to overwrite the deploy tag"
  type        = bool
  default     = false
}

variable "log_group_name" {
  description = "The name of the log group for the ecs cluster"
  type        = string
}
