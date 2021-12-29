locals {
  name            = "${var.name}-nginx-auth-proxy"
  alb_name        = (length(local.name) > 32) ? trim(substr(local.name, 0, 32), "-") : local.name
  alb_name_prefix = lower(substr(replace("BC${var.tags["Environment"]}", "-", ""), 0, 6))

  tags = merge(
    var.tags,
    {
      Name = local.name
    }
  )
}
