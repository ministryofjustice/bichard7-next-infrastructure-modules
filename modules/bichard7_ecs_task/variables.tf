variable "name" {
  type        = string
  description = "The calling layers name"
}

variable "tags" {
  description = "A map of tags"
  type        = map(string)
  default     = {}
}

variable "db_password_arn" {
  type        = string
  description = "The arn of our password parameter"
}

variable "fargate_cpu" {
  description = "The number of cpu units"
  type        = number
}

variable "fargate_memory" {
  description = "The amount of memory that will be given to fargate in Megabytes"
  type        = number
}

variable "bichard_ecr_repository" {
  description = "The url of the ECR repository"
  type        = any
}

variable "bichard_image_tag" {
  description = "The sha256 image hash"
  type        = string
}

variable "cluster_name" {
  description = "The nmae of the cluster as created by base_infra"
  type        = string
}

variable "vpc_id" {
  description = "The id of our vpc"
  type        = string
}

variable "service_subnets" {
  description = "A list of our subnet ids to attach the tasks onto"
  type        = list(string)
}

variable "admin_allowed_cidr" {
  description = "A list of allowed subnet cidrs to access this resource"
  type        = list(string)
}

variable "public_zone_id" {
  description = "The zone id for our public hosted zone so we can use ACM certificates"
  type        = string
}

variable "public_zone_name" {
  description = "The zone name fqdn so we can create a public route53 entry"
  type        = string
}

variable "ssl_certificate_arn" {
  description = "The arn of our ssl certificate"
  type        = string
}

variable "mq_user" {
  description = "The user for auth to the messaging server"
  type        = string
}

variable "mq_password_arn" {
  description = "The arn of the password for the messaging server"
  type        = string
  default     = null
}

variable "mq_conn_str" {
  description = "The connection string for the messaging server"
  type        = string
}

variable "logging_bucket_name" {
  description = "The default logging bucket for lb access logs"
  type        = string
}

variable "log_level" {
  description = "The log level to be used for Bichard running in OpenLiberty"
  type        = string
  default     = "WARN"
}

variable "private_zone_id" {
  description = "The private hosted zone"
  type        = string
}

variable "bichard7_log_group" {
  description = "Our Application log group"
  type        = any
}

variable "db_host" {
  description = "Our db endpoint url or fqdn"
  type        = string
}

variable "db_ssl" {
  description = "Are we forcing an ssl connection to postgres"
  type        = bool
  default     = false
}

variable "db_ssl_mode" {
  description = "Do we need to skip certificate checking"
  type        = string
  default     = ""
}

variable "desired_instance_count" {
  description = "The number of containers we require to be provisioned in the cluster"
  type        = number
}

variable "cluster_kms_key_arn" {
  description = "The kms key arn created in our base_ecs module"
  type        = string
}

variable "jwt_secret_arn" {
  description = "The secret to use for JWT validation"
  type        = string
}

variable "audit_api_key_arn" {
  description = "The API key to use for the audit log API"
  type        = string
}

variable "audit_api_url" {
  description = "The API url to use for the audit log API"
  type        = string
}

variable "health_check_tac" {
  description = "The UTM TAC to use for the health check"
  type        = string
}

variable "service_type" {
  description = "What type of service this is (web|backend)"
  type        = string
}

variable "vpc_endpoint_s3_prefix_list_id" {
  description = "The vpc endpoint prefix list id for s3"
  type        = string
}
