output "elk_endpoint" {
  description = "The internal fqdn for ElasticSearch"
  value       = aws_elasticsearch_domain.os.endpoint
}

output "elk_kibana_endpoint" {
  description = "The internal fqdn for Kibana"
  value       = aws_elasticsearch_domain.os.kibana_endpoint
}

output "elasticsearch_fqdn" {
  description = "The public fqdn for ElasticSearch"
  value       = aws_elasticsearch_domain.os.domain_endpoint_options.*.custom_endpoint
}

output "opensearch_user_ssm_name" {
  description = "The name of our ssm user parameter"
  value       = aws_ssm_parameter.os_user.name
  sensitive   = true
}

output "opensearch_password" {
  description = "The name of our secret password"
  value       = aws_secretsmanager_secret.os_password
}
