output "amq_arn" {
  description = "The ARN of the AmazonMQ broker"
  value       = aws_mq_broker.amq.arn
}

output "messaging_endpoint" {
  description = "The messaging endpoint url"
  value       = aws_mq_broker.amq.instances
}

output "password_arn" {
  description = "The ARN for the password in SSM"
  value       = aws_ssm_parameter.amq_password.arn
}

output "password_value" {
  description = "The value of the MQ password"
  value       = aws_ssm_parameter.amq_password.value
  sensitive   = true
}

output "openwire_url" {
  description = "A generated URL for the ActiveMQ endpoint over the OpenWire protocol"
  value       = "failover:(${join(",", aws_mq_broker.amq.instances[*].endpoints[0])})"
}

output "stomp_url" {
  description = "A generated URL for the ActiveMQ endpoint over the Stomp protocol"
  value       = "failover:(${join(",", aws_mq_broker.amq.instances[*].endpoints[2])})"
}

output "internal_fqdn" {
  description = "The internal FQDN of our db"
  value       = aws_route53_record.mq.fqdn
}
