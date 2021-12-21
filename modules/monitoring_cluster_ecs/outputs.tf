output "prometheus_external_fqdn" {
  description = "The public dns record for our prometheus server"
  value       = aws_route53_record.prometheus_public_record.fqdn
}

output "prometheus_internal_fqdn" {
  description = "The private dns record for our prometheus server"
  value       = aws_route53_record.prometheus_internal_record.fqdn
}

output "grafana_external_fqdn" {
  description = "The public dns record for our grafana server"
  value       = aws_route53_record.grafana_public_record.fqdn
}

output "alert_manager_external_fqdn" {
  description = "The public dns record for our prometheus alert manager"
  value       = aws_route53_record.prometheus_alert_manager_public_record.fqdn
}
