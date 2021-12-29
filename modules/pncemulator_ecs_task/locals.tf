locals {
  name                = "${var.name}-pncemulator"
  alb_name            = (length(local.name) > 32) ? trim(substr(local.name, 0, 32), "-") : local.name
  alb_utm_name_prefix = lower(substr(replace("PU${var.tags["Environment"]}", "-", ""), 0, 6))
  alb_api_name_prefix = lower(substr(replace("PA${var.tags["Environment"]}", "-", ""), 0, 6))

  open_utm_config = {
    pnc_url  = "pnc.cjse.org"
    pnc_port = (var.tags["is-production"] == "true") ? 102 : 30001
    pnc_tsel = (var.tags["is-production"] == "true") ? "NSPISOSI" : "SMP20001"
  }

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

}
