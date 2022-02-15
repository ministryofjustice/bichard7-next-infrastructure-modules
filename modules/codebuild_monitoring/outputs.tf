output "grafana_external_fqdn" {
  description = "The public dns record for our grafana server"
  value       = aws_route53_record.grafana_public_record.fqdn
}
