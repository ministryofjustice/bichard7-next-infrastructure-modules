locals {
  cloudwatch_alb_name       = (length("${var.name}-cwatch") > 32) ? trim(substr("${var.name}-cwatch", 0, 32), "-") : "${var.name}-cwatch"
  blackbox_alb_name         = (length("${var.name}-bbox") > 32) ? trim(substr("${var.name}-bbox", 0, 32), "-") : "${var.name}-bbox"
  prometheus_alb_name       = (length("${var.name}-monitor") > 32) ? trim(substr("${var.name}-monitor", 0, 32), "-") : "${var.name}-monitor"
  prometheus_alert_alb_name = (length("${var.name}-alert") > 32) ? trim(substr("${var.name}-alert", 0, 32), "-") : "${var.name}-alert"
  grafana_alb_name          = (length("${var.name}-grafana") > 32) ? trim(substr("${var.name}-grafana", 0, 32), "-") : "${var.name}-grafana"
  logstash_alb_name         = (length("${var.name}-logstash") > 32) ? trim(substr("${var.name}-logstash", 0, 32), "-") : "${var.name}-logstash"

  prometheus_alb_name_prefix       = lower(substr(replace("P${var.tags["Environment"]}", "-", ""), 0, 6))
  prometheus_alert_alb_name_prefix = lower(substr(replace("A${var.tags["Environment"]}", "-", ""), 0, 6))
  cloudwatch_alb_name_prefix       = lower(substr(replace("C${var.tags["Environment"]}", "-", ""), 0, 6))
  blackbox_alb_name_prefix         = lower(substr(replace("B${var.tags["Environment"]}", "-", ""), 0, 6))
  grafana_alb_name_prefix          = lower(substr(replace("G${var.tags["Environment"]}", "-", ""), 0, 6))
  logstash_alb_name_prefix         = lower(substr(replace("L${var.tags["Environment"]}", "-", ""), 0, 6))

  prometheus_data_dir = "/data"

  ecr_account_id = var.parent_account_id == null ? data.aws_caller_identity.current.account_id : var.parent_account_id

  application_cpu    = (ceil(var.fargate_cpu / 6) * 5)
  application_memory = (ceil(var.fargate_memory / 6) * 5)
  config_cpu         = var.fargate_cpu - local.application_cpu
  config_memory      = var.fargate_memory - local.application_memory

  grafana_domain    = "grafana.${var.public_zone_name}"
  grafana_data_path = "/grafana"

  pnc_port = (var.tags["is-production"] == "true") ? 102 : 30001

  provision_alerts = (lower(lookup(var.tags, "workspace", "unknown")) == "production") ? 1 : 0
}
