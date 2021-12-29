output "alb_dns" {
  description = "DNS entry for load balancer"
  value       = module.s3_web_proxy_ecs_alb.dns_name
}

output "fqdn" {
  description = "The public fqdn for the alb"
  value       = aws_route53_record.friendly_dns_name.fqdn
}
