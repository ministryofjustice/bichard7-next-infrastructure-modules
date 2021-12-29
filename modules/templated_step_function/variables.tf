variable "template_file_bucket" {
  description = "The name of the bucket in the parent account that contains the template file"
  type        = string
}

variable "template_file_key" {
  description = "The template file key for the S3 object in the bucket"
  type        = string
}

variable "template_variables" {
  description = "The keyed variables to replace in the template file"
  type        = map(string)
}

variable "name" {
  description = "The name of the Step Function"
  type        = string
}

variable "iam_role_arn" {
  description = "The ARN of the IAM Role to attach to the Step Function"
  type        = string
}

variable "cloud_watch_logs_group_arn" {
  description = "The ARN of Cloudwatch logs group"
  type        = string
}

variable "tags" {
  description = "Tags to apply to all created resources"
  type        = map(string)
}
