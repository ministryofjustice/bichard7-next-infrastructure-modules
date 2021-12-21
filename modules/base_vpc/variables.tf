variable "cidr_block" {
  description = "The base cidr block"
  type        = string
}

variable "name_prefix" {
  description = "The prefix used in naming things"
  type        = string
}

variable "region_id" {
  description = "The current region"
  type        = string
}

variable "tags" {
  description = "A map of environment tags"
  type        = map(string)
}
