output "audit_logging_portal_dns_lb" {
  description = "DNS entry for load balancer"
  value       = module.audit_logging_portal_ecs_alb.dns_name
}

output "external_fqdn" {
  description = "The external FQDN of our db"
  value       = aws_route53_record.audit_logging.fqdn
}

output "target_group_arn" {
  description = "The target group arn for the audit logging cluster"
  value       = module.audit_logging_portal_ecs_alb.target_group.arn
}

output "load_balancer_arn" {
  description = "The load balancer arn for the audit logging cluster"
  value       = module.audit_logging_portal_ecs_alb.load_balancer.arn
}
