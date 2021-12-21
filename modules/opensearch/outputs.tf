output "elk_endpoint" {
  description = "The internal fqdn for ElasticSearch"
  value       = aws_elasticsearch_domain.es.endpoint
}

output "elk_kibana_endpoint" {
  description = "The internal fqdn for Kibana"
  value       = aws_elasticsearch_domain.es.kibana_endpoint
}

output "elasticsearch_fqdn" {
  description = "The public fqdn for ElasticSearch"
  value       = aws_elasticsearch_domain.es.domain_endpoint_options.*.custom_endpoint
}

output "elasticsearch_user_ssm_name" {
  description = "The name of our ssm user parameter"
  value       = aws_ssm_parameter.es_user.name
  sensitive   = true
}

output "elasticsearch_password_ssm_name" {
  description = "The name of our ssm password parameter"
  value       = aws_ssm_parameter.es_password.name
  sensitive   = true
}
