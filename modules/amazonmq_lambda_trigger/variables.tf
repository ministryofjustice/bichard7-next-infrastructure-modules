variable "region_id" {
  description = "The Id of the current AWS Region"
  type        = string
}

variable "assume_role_arn" {
  description = "The ARN of the IAM Role to assume for the trigger"
  type        = string
}

variable "queue_arn" {
  description = "The ARN of the AmazonMQ Queue to which to subscribe"
  type        = string
}

variable "queue_name" {
  description = "The name of the AmazonMQ Queue to which to subscribe"
  type        = string
}

variable "lambda_arn" {
  description = "The ARN of the AWS Lambda Function to which to attach the trigger"
  type        = string
}

variable "queue_secret_arn" {
  description = "The ARN of the AWS Secrets Manager Secret that contains the username and password for the AmazonMQ broker"
  type        = string
}
