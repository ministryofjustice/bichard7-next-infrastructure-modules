variable "vpc_id" {
  description = "VPC ID to attach to."
  type        = string
}

variable "vpc_name" {
  description = "The VPC name is used to name the flow log resources."
  type        = string
}

variable "vpc_flow_log_group" {
  description = "The outputs from the creation of our vpc_flow_logs log group"
  type        = any
}

variable "tags" {
  description = "A map of tags to apply to this resource"
  type        = map(string)
}
