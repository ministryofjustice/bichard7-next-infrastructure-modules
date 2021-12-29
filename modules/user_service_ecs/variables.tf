variable "admin_allowed_cidr" {
  description = "A list of subnet CIDRs allowed to access this resource"
  type        = list(string)
}

variable "db_host" {
  description = "The FQDN or endpoint URL of our database"
  type        = string
}

variable "db_password_arn" {
  description = "The arn of the database password parameter"
  type        = string
}

variable "db_ssl" {
  description = "Whether to force an SSL connection to the Postgres DB"
  type        = bool
  default     = true
}

variable "fargate_cpu" {
  description = "The number of CPU units"
  type        = number
}

variable "fargate_memory" {
  description = "The amount of memory that will be given to fargate in Megabytes"
  type        = number
}

variable "incorrect_delay" {
  description = "The amount of time (in seconds) to wait between successive login attempts for the same user"
  type        = number
}

variable "hide_non_prod_banner" {
  description = "Whether to show the 'development environment' warning banner should be shown"
  type        = string
  default     = "false"
}

variable "logging_bucket_name" {
  description = "The default logging bucket for lb access logs"
  type        = string
}

variable "name" {
  type        = string
  description = "The calling layers name"
}

variable "public_zone_id" {
  description = "The zone id for our public hosted zone so we can use ACM certificates"
  type        = string
}

variable "service_subnets" {
  description = "A list of our subnet ids to attach the tasks onto"
  type        = list(string)
}

variable "ssl_certificate_arn" {
  description = "The arn of our ssl certificate"
  type        = string
}

variable "tags" {
  description = "A map of tags"
  type        = map(string)
  default     = {}
}

variable "token_expires_in" {
  description = "How long the authentication tokens should be valid for after logging in"
  type        = string
  default     = "10 minutes" # tfsec:ignore:GEN001
}

variable "user_service_ecs_arn" {
  description = "The arn of our user portal"
  type        = string
}

variable "user_service_ecs_image_url" {
  description = "Our image URL to deploy"
  type        = string
}

variable "user_service_ecs_image_hash" {
  description = "The hash of our deployable image"
  type        = string
}

variable "user_service_log_group" {
  description = "The log group we will be pushing our logs to"
  type        = any
}

variable "vpc_id" {
  description = "The id of our vpc"
  type        = string
}

variable "desired_instance_count" {
  description = "The number of containers we wish to provision"
  type        = number
  default     = 1
}

variable "override_deploy_tags" {
  description = "Required for CI/CD, do we want to allow us to overwrite the deploy tag"
  type        = bool
  default     = false
}

variable "email_from_address" {
  description = "The email from address our recipients see"
  type        = string
}

variable "smtp_host" {
  description = "The host of our smtp server"
  type        = string
}

variable "smtp_user" {
  description = "Our smtp user name for the service"
  type        = string
}

variable "smtp_password" {
  description = "Our smtp user password"
  type        = string
}

variable "smtp_tls" {
  description = "Are we using tls encryption"
  type        = bool
}

variable "smtp_port" {
  description = "The port we are using for the SMTP service"
  type        = number
}

variable "jwt_secret_arn" {
  description = "The arn of the JWT Secret parameter"
  type        = string
}

variable "cookie_secret_arn" {
  description = "The arn of the Cookie Secret parameter"
  type        = string
}

variable "csrf_cookie_secret_arn" {
  description = "The arn of the CSRF Cookie Secret parameter"
  type        = string
}

variable "crsf_form_secret_arn" {
  description = "The arn of the CSRF Form Secret parameter"
  type        = string
}

variable "cookies_secure" {
  description = "Whether the user service should use secure cookies"
  type        = string
  default     = "true"
}
