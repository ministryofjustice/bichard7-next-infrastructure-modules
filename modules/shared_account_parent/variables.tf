variable "tags" {
  type        = map(string)
  description = "A list of AWS tags"
}

variable "buckets" {
  description = "A list of shared buckets that the parent allows the children to access"
  type        = list(string)
  default     = []
}
