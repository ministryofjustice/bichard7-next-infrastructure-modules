locals {
  name            = "${var.name}-audit-portal"
  alb_name        = (length(local.name) > 32) ? trim(substr(local.name, 0, 32), "-") : local.name
  alb_name_prefix = lower(substr(replace("BC${var.tags["Environment"]}", "-", ""), 0, 6))

  portal_cpu_units    = ((var.fargate_cpu / 4) * 3)
  portal_memory_units = ((var.fargate_memory / 4) * 3)
  config_cpu_units    = (var.fargate_cpu / 4)
  config_memory_units = (var.fargate_memory / 4)

  tags = merge(
    var.tags,
    {
      Name = local.name
    }
  )

}
