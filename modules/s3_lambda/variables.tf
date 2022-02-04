variable "bucket_name" {
  description = "The name of the bucket"
  type        = string
}

variable "filename" {
  description = "The filename of the lambda artifact in S3"
  type        = string
}

variable "lambda_directory" {
  description = "The directory where our artifacts are stored in S3"
  type        = string
}

variable "resource_prefix" {
  description = "A prefix for our function name for multi environment deployments"
  type        = string
}

variable "reserved_concurrent_executions" {
  description = "Amount of reserved concurrent executions for this lambda function"
  type        = number
  default     = -1
}

variable "timeout" {
  description = "Execution timeout in seconds for this lambda function"
  type        = number
  default     = 30
}

variable "function_name" {
  description = "The name of our lambda function"
  type        = string
}

variable "iam_role_arn" {
  description = "The ARN of our lambda execution role"
  type        = string
}

variable "vpc_config" {
  description = "The configuration values to connect the Lambda to a VPC"
  type = object({
    subnet_ids         = set(string)
    security_group_ids = set(string)
  })
  default = null
}

variable "environment_variables" {
  description = "A map of environment variables"
  type        = map(string)
  default     = null
}

variable "tags" {
  description = "A map of tags for this object"
  type        = map(string)
  default     = {}
}

variable "memory_size" {
  description = "The memory size of the lambda"
  type        = number
  default     = 128
}

variable "lambda_runtime" {
  description = "The runtime we want use for the labmda"
  type        = string
  default     = "nodejs14.x"
}
