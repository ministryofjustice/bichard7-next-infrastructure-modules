output "user_service_dns_lb" {
  description = "DNS entry for user service load balancer"
  value       = module.user_service_alb.dns_name
}

output "external_fqdn" {
  description = "The external FQDN of the user service"
  value       = aws_route53_record.user_service.fqdn
}

output "target_group_arn" {
  description = "The arn of our user service target group"
  value       = module.user_service_alb.target_group.arn
}

output "lb_arn" {
  description = "The arn of our user service load balancer"
  value       = module.user_service_alb.load_balancer.arn
}
