variable "tags" {
  description = "A map of resource tags"
  type        = map(string)
}

variable "name" {
  description = "Our resource name"
  type        = string
}

variable "notifications_channel_name" {
  default     = "moj-cjse-bichard-notifications"
  type        = string
  description = "Our slack channel for build notifications"
}
