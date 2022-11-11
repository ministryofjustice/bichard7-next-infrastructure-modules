data "aws_caller_identity" "current" {}

data "aws_route53_zone" "cjse_dot_org" {
  zone_id = var.private_zone_id
}

data "template_file" "bichard_fargate" {
  template = file("${path.module}/templates/container_definition_json.tpl")

  vars = {
    APP_NAME              = local.app_name
    CPU                   = var.fargate_cpu
    REPOSITORY_URL        = var.bichard_ecr_repository.repository_url
    IMAGE_TAG             = var.bichard_image_tag
    MEMORY                = var.fargate_memory
    LOG_GROUP             = var.bichard7_log_group.name
    LOG_STREAM_PREFIX     = "Bichard-WAS"
    DB_USER               = "bichard"
    MQ_USER               = var.mq_user
    MQ_CONN_STR           = var.mq_conn_str
    LOG_LEVEL             = var.log_level
    DB_HOST               = var.db_host
    DB_SSL                = var.db_ssl
    DB_SSL_MODE           = var.db_ssl_mode
    SECRETS               = jsonencode([for k, v in local.secrets : { name = k, valueFrom = v } if v != null])
    HEALTH_CHECK_TAC      = var.health_check_tac
    DEPLOY_ENV            = local.deploy_env
    TAC_SUFFIX            = local.tac_suffix
    DISABLE_MDB           = var.service_type == "backend" ? "" : "true"
    BC_PROXY_URL          = var.service_type == "web" ? "oltp://disabled:0/disabled" : "oltp://bc.cjse.org:31004/BCU31004"
    AUDIT_LOGGING_API_URL = var.audit_api_url
    LOG_PNC_REQUESTS      = (terraform.workspace == "production") ? "false" : "true"
  }
}

data "template_file" "allow_ecr" {
  template = file("${path.module}/policies/allow_ecr.json.tpl")

  vars = {
    ecr_arn = var.bichard_ecr_repository.arn
  }
}

data "template_file" "allow_kms" {
  template = file("${path.module}/policies/allow_kms.json.tpl")

  vars = {
    account_id = data.aws_caller_identity.current.account_id
  }
}

data "template_file" "allow_ssm" {
  template = file("${path.module}/policies/allow_ssm.json.tpl")

  vars = {
    ssm_params = jsonencode(local.allowed_resources)
  }
}

data "aws_security_group" "bichard" {
  name = "${var.name}-${var.service_type}"
}

data "aws_security_group" "bichard_alb" {
  name = "${var.name}-alb-${var.service_type}"
}

data "aws_security_group" "bichard_amq" {
  name = "${var.name}-amq"
}

data "aws_security_group" "bichard_aurora" {
  name = "${var.name}-aurora"
}
