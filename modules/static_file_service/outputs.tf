output "alb_dns" {
  description = "DNS entry for load balancer"
  value       = module.static_file_service.alb_dns
}

output "fqdn" {
  description = "The public fqdn for the alb"
  value       = module.static_file_service.fqdn
}
