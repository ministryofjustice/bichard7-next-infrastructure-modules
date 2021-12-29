data "aws_caller_identity" "current" {}

data "aws_region" "current" {}

data "template_file" "beanconnect_fargate" {
  template = file("${path.module}/templates/beanconnect_task.json.tpl")

  vars = {
    beanconnect_image = "${var.beanconnect_ecs_image_url}@${aws_ssm_parameter.beanconnect_deploy_tag.value}"
    cpu_units         = var.fargate_cpu
    memory_units      = var.fargate_memory
    log_group         = var.beanconnect_log_group.name
    log_stream_prefix = "bichard-beanconnect"
    region            = data.aws_region.current.name
    listener_port     = local.open_utm_config.pnc_port
    eis_host          = local.open_utm_config.pnc_url
    eis_tsel          = local.open_utm_config.pnc_tsel
    proxy_host_name   = local.open_utm_config.proxy_host_name
    setup_hosts_file  = true
    password_arn      = aws_ssm_parameter.beanconnect_password.arn

    pnc_lpap    = local.open_utm_config.pnc_lpap
    pnc_aeq     = local.open_utm_config.pnc_aeq
    pnc_contwin = local.open_utm_config.pnc_contwin
    tac_suffix  = local.tac_suffix
  }
}

data "aws_availability_zones" "this" {}

data "aws_route53_zone" "cjse_dot_org" {
  zone_id = var.private_zone_id
}

data "aws_security_group" "beanconnect" {
  name = "${var.name}-beanconnect"
}

data "aws_security_group" "bichard7" {
  name = "${var.name}-backend"
}
