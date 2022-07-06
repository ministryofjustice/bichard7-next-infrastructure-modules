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

data "template_file" "ui_fargate" {
  template = file("${path.module}/templates/ui_task.json.tpl")

  vars = {
    ui_image          = "${var.ui_ecs_image_url}@${aws_ssm_parameter.ui_deploy_tag.value}"
    ui_cpu_units      = var.fargate_cpu
    ui_memory_units   = var.fargate_memory
    log_group         = var.ui_log_group.name
    log_stream_prefix = "bichard-ui"
    region            = data.aws_region.current.name
  }
}
