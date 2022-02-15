output "grafana_external_fqdn" {
  description = "The public dns record for our grafana server"
  value       = aws_route53_record.grafana_public_record.fqdn
}

output "grafana_api_key" {
  description = "The api key we can use to provision grafana resources"
  sensitive   = true
  value       = grafana_api_key.admin_api_key.key
}
