output "pncemulator_dns_lb" {
  description = "DNS entry for load balancer"
  value       = module.pncemulator_ecs_alb.dns_name
}
