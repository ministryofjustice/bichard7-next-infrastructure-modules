variable "environment" {
  type        = string
  description = "The target environment, will map to the terraform workspace"
}

variable "tags" {
  type        = map(string)
  description = "A map of environment tags"
  default     = {}
}

variable "fargate_cpu" {
  description = "The number of cpu units"
  type        = number
  default     = 1024
}

variable "fargate_memory" {
  description = "The amount of memory that will be given to fargate in Megabytes"
  type        = number
  default     = 2048
}

variable "name" {
  description = "The deployments name"
  type        = string
}

variable "vpc_id" {
  description = "The vpc id for our security groups to bind to"
  type        = string
}

variable "allowed_ingress_cidr" {
  description = "An allowed list of ingress CIDRS in our vpc"
  type        = list(string)
  default     = []
}

variable "service_subnets" {
  description = "A list of our subnets"
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

variable "private_zone_id" {
  description = "The zone id of our privated hosted zone"
  type        = string
}

variable "logging_bucket_name" {
  description = "The default logging bucket for lb access logs"
  type        = string
}

variable "prometheus_data_directory" {
  description = "The absolute path where we want to store our Prometheus data"
  type        = string
  default     = "/data"
}

variable "prometheus_data_retention_days" {
  description = "The number of days we want to store our prometheus data for"
  type        = string
  default     = "180"
}

variable "prometheus_efs_filesystem_id" {
  description = "The ECS ID to mount our filessytem"
  type        = string
}

variable "prometheus_efs_filesystem_path" {
  description = "The ECS ID to mount our filesystem"
  type        = string
  default     = "/data/prometheus"
}

variable "ecs_to_efs_sg_id" {
  description = "The security group id for our ecs/efs communication"
  type        = string
}

variable "parent_account_id" {
  description = "The id of the parent account"
  type        = string
  default     = null
}

variable "prometheus_log_group" {
  description = "Our prometheus log group"
  type        = any
}

variable "grafana_image" {
  description = "The url of our grafana ecs image we want to use"
  type        = string
}

variable "efs_access_points" {
  description = "A list of efs access points for data storage"
  type        = any
}

variable "app_targetgroup_arn" {
  description = "The arn of our application target group"
  type        = string
}

variable "user_service_targetgroup_arn" {
  description = "The arn of our user service target group"
  type        = string
}

variable "beanconnect_targetgroup_arn" {
  description = "The arn of our beanconnect target group"
  type        = string
}

variable "remote_exec_enabled" {
  description = "Do we want to allow remote-exec onto these containers"
  type        = bool
  default     = true
}

variable "slack_channel_name" {
  description = "The slack channel we are going to send our alerts to"
  type        = string
  default     = "moj-cjse-bichard-alerts"
}

variable "slack_webhook_url" {
  description = "The slack webhook url we are using to push our notifications"
  type        = string
}

variable "grafana_db_instance_class" {
  description = "The class of DB instance we are using for Grafana"
  default     = "db.t4g.medium"
  type        = string
}

variable "grafana_db_instance_count" {
  description = "The number of DB instance we are using for Grafana"
  default     = 3
  type        = number
}

variable "using_smtp_service" {
  description = "Are we using the CJSM smtp service"
  type        = bool
  default     = false
}

variable "idle_timeout" {
  description = "How long in seconds before we terminate a connection"
  type        = number
  default     = 180
}

### Security groups
variable "prometheus_exporter_security_group_id" {
  type = string
}

variable "prometheus_cloudwatch_exporter_alb_id" {
  type = string
}

variable "prometheus_blackbox_exporter_security_group_id" {
  type = string
}

variable "prometheus_blackbox_exporter_alb_id" {
  type = string
}

variable "prometheus_security_group_id" {
  type = string
}

variable "prometheus_alb_id" {
  type = string
}

variable "prometheus_alert_manager_alb_id" {
  type = string
}

variable "grafana_security_group_id" {
  type = string
}

variable "grafana_alb_security_group_id" {
  type = string
}

variable "grafana_db_security_group_id" {
  type = string
}

variable "logstash_security_group_id" {
  type = string
}

variable "logstash_alb_security_group_id" {
  type = string
}

variable "opensearch_security_group_id" {
  type = string
}

variable "user_service_alb_id" {
  type = string
}

variable "bichard_alb_web_id" {
  type = string
}

variable "bichard_alb_backend_id" {
  type = string
}

variable "prometheus_ecs_task_def" {
  description = "ecs task definition base encoded"
  type        = string
}

variable "prometheus_blackbox_exporter_ecs_task_def" {
  description = "ecs task definition base encoded"
  type        = string
}

variable "prometheus_cloudwatch_exporter_ecs_task_def" {
  description = "ecs task definition base encoded"
  type        = string
}

variable "logstash_ecs_task_def" {
  description = "ecs task definition base encoded"
  type        = string
}

variable "admin_htaccess_username" {
  description = "prometheus username"
  type        = string
}

variable "admin_htaccess_password_arn" {
  description = "prometheus password arn"
  type        = string
}

variable "os_username_arn" {
  description = "opensearch username arn"
  type        = string
}
