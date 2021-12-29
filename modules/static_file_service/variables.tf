variable "tags" {
  description = "The tags for the resources"
  type        = map(string)
}

variable "logging_bucket_name" {
  description = "The default logging bucket for lb access logs"
  type        = string
}

variable "public_zone_id" {
  description = "The zone id for our public hosted zone so we can use ACM certificates"
  type        = string
}

variable "service_subnets" {
  description = "The subnets on which our alb will serve traffic"
  type        = list(string)
}

variable "ssl_certificate_arn" {
  description = "The arn of our ssl certificate"
  type        = string
}

variable "vpc_id" {
  description = "The ID of the VPC that the RDS cluster will be created in"
  type        = string
}

variable "name" {
  description = "Name to be used on all the resources as identifier"
  type        = string
}

variable "s3_web_proxy_image" {
  description = "The web proxy image to deploy"
  type        = string
}

variable "s3_web_proxy_arn" {
  description = "The arn for the web proxy ecr repository"
  type        = string
}

variable "parent_account_id" {
  description = "The id of the parent account"
  type        = string
}
