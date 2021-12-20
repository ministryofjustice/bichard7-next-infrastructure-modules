output "cluster_endpoint" {
  description = "The cluster endpoint url"
  value       = aws_rds_cluster.aurora_cluster.endpoint
}

output "password_arn" {
  description = "The ARN for the password in SSM"
  value       = aws_ssm_parameter.db_password.arn
}

output "internal_fqdn" {
  description = "The internal FQDN of our db"
  value       = aws_route53_record.db.fqdn
}
