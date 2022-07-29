locals {
  name            = "${var.name}-ui"
  alb_name        = (length(local.name) > 32) ? trim(substr(local.name, 0, 32), "-") : local.name
  alb_name_prefix = lower(substr(replace("BC${var.tags["Environment"]}", "-", ""), 0, 6))

  certs_cpu_units    = (var.fargate_cpu / 4)
  certs_memory_units = (var.fargate_memory / 4)
  ui_cpu_units       = ((var.fargate_cpu / 4) * 3)
  ui_memory_units    = ((var.fargate_memory / 4) * 3)

  allowed_resources = [var.db_password_arn]
  secrets = {
    "DB_PASSWORD" = var.db_password_arn
  }

  tags = merge(
    var.tags,
    {
      Name = local.name
    }
  )
}
