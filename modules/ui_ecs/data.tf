data "aws_region" "current" {}

data "aws_route53_zone" "public_zone" {
  zone_id = var.public_zone_id
}

data "aws_security_group" "ui_alb" {
  name = "${var.name}-ui-alb"
}

data "aws_security_group" "ui_ecs" {
  name = "${var.name}-ui-ecs"
}

data "terraform_remote_state" "base_infra" {
  backend = "s3"
  config = {
    bucket         = local.remote_bucket_name
    dynamodb_table = "${local.remote_bucket_name}-lock"
    key            = "env:/${terraform.workspace}/${var.account}/base_infra/tfstate"
    region         = "eu-west-2"
  }
}

data "template_file" "ui_fargate" {
  template = file("${path.module}/templates/ui_task.json.tpl")

  vars = {
    ui_image          = "${var.ui_ecs_image_url}@${aws_ssm_parameter.ui_deploy_tag.value}"
    ui_cpu_units      = var.fargate_cpu
    ui_memory_units   = var.fargate_memory
    log_group         = var.ui_log_group.name
    log_stream_prefix = "bichard-ui"
    region            = data.aws_region.current.name
    DB_HOST           = var.db_host
    DB_USER           = "bichard"
    DB_SSL            = var.db_ssl
    SECRETS           = jsonencode([for k, v in local.secrets : { name = k, valueFrom = v } if v != null])
  }
}

data "aws_ec2_managed_prefix_list" "s3" {
  name = "com.amazonaws.${data.aws_region.current.name}.s3"
}

data "aws_security_group" "bichard_aurora" {
  name = "${var.name}-aurora"
}
