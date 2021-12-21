output "endpoint_url" {
  description = "The aws vpn endpoint url"
  value       = local.endpoint_url
}

output "dns_endpoint_security_group_id" {
  description = "The ID of the dns_endpoint security group"
  value       = aws_security_group.dns_endpoint.id
}
