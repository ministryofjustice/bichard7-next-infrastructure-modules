locals {
  name            = "${var.name}-beanconnect"
  alb_name        = (length(local.name) > 32) ? trim(substr(local.name, 0, 32), "-") : local.name
  alb_name_prefix = lower(substr(replace("BC${var.tags["Environment"]}", "-", ""), 0, 6))

  open_utm_config = {
    pnc_url         = "pnc.cjse.org"
    pnc_port        = (var.tags["is-production"] == "true") ? 102 : 30001
    pnc_tsel        = (var.tags["is-production"] == "true") ? "NSPISOSI" : "SMP20001"
    pnc_lpap        = (var.pnc_lpap != null) ? var.pnc_lpap : "LPBICHCD"
    pnc_aeq         = (var.pnc_aeq != null) ? var.pnc_aeq : "7707"
    pnc_contwin     = (var.pnc_contwin != null) ? var.pnc_contwin : "9"
    proxy_host_name = (var.pnc_proxy_hostname != null) ? var.pnc_proxy_hostname : "LOCAL"
  }

  allowed_resources = [
    aws_ssm_parameter.beanconnect_password.arn
  ]

  container_count = (
    (var.desired_instance_count == null) ?
    length(data.aws_availability_zones.this.zone_ids) : var.desired_instance_count
  )

  tags = merge(
    var.tags,
    {
      Name = local.name
    }
  )

  tac_suffix = (terraform.workspace == "production") ? "M1L" : "M5B"
}
