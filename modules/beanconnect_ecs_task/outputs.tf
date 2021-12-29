output "beanconnect_dns_lb" {
  description = "DNS entry for load balancer"
  value       = module.beanconnect_ecs_alb.dns_name
}

output "internal_fqdn" {
  description = "The internal FQDN of our db"
  value       = aws_route53_record.bc.fqdn
}

output "target_group_arn" {
  description = "The target group arn for beanconnect"
  value       = module.beanconnect_ecs_alb.target_group.arn
}

output "load_balancer_arn" {
  description = "The load balancer arn for beanconnect"
  value       = module.beanconnect_ecs_alb.load_balancer.arn
}

output "pnc_proxy_endpoint_port" {
  description = "The port we are connecting to the pnc proxy on"
  value       = local.open_utm_config.pnc_port
}
