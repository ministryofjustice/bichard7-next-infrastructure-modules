locals {
  name               = var.name
  alb_name           = (length(var.name) > 32) ? trim(substr(var.name, 0, 32), "-") : var.name
  alb_name_prefix    = lower(substr(replace(local.name, "-", ""), 0, 6))
  s3_web_proxy_image = var.s3_web_proxy_image

  scanning_cpu_units    = ((var.fargate_cpu / 4) * 3)
  scanning_memory_units = ((var.fargate_memory / 4) * 3)
  config_cpu_units      = (var.fargate_cpu / 4)
  config_memory_units   = (var.fargate_memory / 4)

  tags = merge(
    var.tags,
    {
      Name = local.name
    }
  )
}
