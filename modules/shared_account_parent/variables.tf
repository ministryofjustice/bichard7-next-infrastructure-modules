variable "tags" {
  type        = map(string)
  description = "A list of AWS tags"
}

variable "buckets" {
  description = "A list of shared buckets that the parent allows the children to access"
  type        = list(string)
  default     = []
}

variable "ebs_encryption_key" {
  description = "The shared key arn that we can use to share amis"
  type        = string
}
