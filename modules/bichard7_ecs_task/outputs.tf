output "bichard7_dns_lb" {
  description = "DNS entry for load balancer"
  value       = module.bichard_ecs_alb.dns_name
}

output "bichard7_public_lb_dns" {
  description = "The public dns entry for the alb"
  value       = aws_route53_record.bichard_public_record.fqdn
}

output "internal_fqdn" {
  description = "The internal FQDN of our db"
  value       = aws_route53_record.bichard7.fqdn
}

output "target_group_arn" {
  description = "The arn of our target group for bichard7 app"
  value       = module.bichard_ecs_alb.target_group.arn
}

output "load_balancer_arn" {
  description = "The arn of our load balancer for bichard7 app"
  value       = module.bichard_ecs_alb.load_balancer.arn
}
