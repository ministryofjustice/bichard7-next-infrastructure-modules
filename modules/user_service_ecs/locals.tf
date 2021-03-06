locals {
  name            = "${var.name}-user-service"
  alb_name        = (length(local.name) > 32) ? trim(substr(local.name, 0, 32), "-") : local.name
  alb_name_prefix = lower(substr(replace("BC${var.tags["Environment"]}", "-", ""), 0, 6))

  certs_cpu_units           = (var.fargate_cpu / 4)
  certs_memory_units        = (var.fargate_memory / 4)
  user_service_cpu_units    = ((var.fargate_cpu / 4) * 3)
  user_service_memory_units = ((var.fargate_memory / 4) * 3)

  tags = merge(
    var.tags,
    {
      Name = local.name
    }
  )
}
