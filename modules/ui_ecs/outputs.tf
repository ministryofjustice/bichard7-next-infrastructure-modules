output "ui_dns_lb" {
  description = "DNS entry for ui load balancer"
  value       = module.ui_alb.dns_name
}

output "external_fqdn" {
  description = "The external FQDN of the ui"
  value       = aws_route53_record.ui.fqdn
}

output "target_group_arn" {
  description = "The arn of our iu target group"
  value       = module.ui_alb.target_group.arn
}

output "lb_arn" {
  description = "The arn of our ui load balancer"
  value       = module.ui_alb.load_balancer.arn
}
