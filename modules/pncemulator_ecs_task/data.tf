data "aws_caller_identity" "current" {}

data "aws_region" "current" {}

data "template_file" "pncemulator_fargate" {
  template = file("${path.module}/templates/pncemulator_task.json.tpl")

  vars = {
    pncemulator_image = var.pncemulator_ecs_image_url
    cpu_units         = var.fargate_cpu
    memory_units      = var.fargate_memory
    log_group         = var.pncemulator_log_group.name
    log_stream_prefix = "bichard-pncemulator"
    region            = data.aws_region.current.name
  }
}

data "aws_security_group" "pncemulator" {
  name = "${var.name}-pncemulator"
}

data "aws_availability_zones" "this" {}
