locals {
  ecs_name          = var.name
  fargate_name      = var.name
  cluster_name      = var.name
  service_name      = "${var.cluster_name}-${var.service_type}"
  task_family_name  = var.name
  alb_name          = trim(substr("${var.name}-${var.service_type}", 0, 32), "-")
  target_group_name = var.name
  app_name          = "bichard7-${var.service_type}"

  allowed_resources = [
    var.db_password_arn,
    var.mq_password_arn,
    var.jwt_secret_arn,
    var.audit_api_key_arn
  ]

  secrets = {
    "DB_PASSWORD"           = var.db_password_arn,
    "MQ_PASSWORD"           = var.mq_password_arn,
    "TOKEN_SECRET"          = var.jwt_secret_arn,
    "AUDIT_LOGGING_API_KEY" = var.audit_api_key_arn
  }

  tags = merge(
    var.tags,
    {
      Name = var.cluster_name
    }
  )

  deploy_env = (terraform.workspace == "production") ? "prod" : "test"
  tac_suffix = (terraform.workspace == "production") ? "M1L" : "M5B"

}
