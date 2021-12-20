output "security_group_ids" {
  description = "A map of security group ids so we can add extra rules"
  value = {
    sonar     = aws_security_group.sonar_security_group.id
    sonar_alb = aws_security_group.sonar_alb.id
    exporter  = aws_security_group.sonar_security_group.id
    alb       = aws_security_group.sonar_alb.id
  }
}

output "sonar_friendly_dns_name" {
  description = "The dns name of our sonar deploy"
  value       = aws_route53_record.sonar_record.fqdn
}
