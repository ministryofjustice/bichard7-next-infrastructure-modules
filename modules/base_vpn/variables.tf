variable "cert_dir" {
  description = "The directory in which our vpn certificates live"
  type        = string
}

variable "domain" {
  description = "The domain name used for the certificate"
  type        = string
}

variable "allowed_subnet_ids" {
  type        = list(string)
  description = "the vpn will have access to these subnets"
}

variable "allowed_subnet_cidr_blocks" {
  type        = list(string)
  description = "the vpn will have access to these subnets"
}

variable "name_prefix" {
  description = "A prefix used for naming"
  type        = string
}

variable "tags" {
  description = "A map of environmental tags"
  type        = map(string)
}

variable "client_cidr_block" {
  description = "The allowed cidr blocks"
  type        = string
}

variable "vpc_id" {
  description = "The vpc id"
  type        = string
}

variable "aws_role" {
  description = "The name of the role we want to use for our sts assume call"
  default     = ""
  type        = string
}

variable "vpn_log_group" {
  description = "The cloudwatch log group for our VPN"
  type        = any
}
