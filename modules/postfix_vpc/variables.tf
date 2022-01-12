variable "name" {
  description = "The name from our label module"
  type        = string
}

variable "tags" {
  description = "A map of resource tags"
  type        = map(string)
}

variable "aws_logs_bucket" {
  description = "The bucket we use to log all of our bucket actions"
  type        = string
}

variable "vpc_cidr_block" {
  description = "Our cidr block to apply to this vpc"
  type        = string
  default     = null
}

variable "bastion_count" {
  description = "How many bastion instances do we want"
  type        = number
  default     = 1
}

variable "ingress_cidr_blocks" {
  description = "A list of ingress cidr blocks to route to our private cidrs"
  type        = list(string)
}

variable "public_zone_id" {
  description = "The public zone we use to create records on"
  type        = string
}

variable "application_cidr" {
  description = "The application cidr block"
  type        = list(string)
}

variable "cloudwatch_notifications_arn" {
  description = "The arn of our cloudwatch sns notifications arn"
  type        = string
}

variable "postfix_ecs" {
  description = "A map of postfix ecr values"
  type        = map(string)
}
