output "nginx_auth_proxy_dns_lb" {
  description = "DNS entry for NGINX auth proxy load balancer"
  value       = aws_alb.auth_proxy_alb.dns_name
}

output "external_fqdn" {
  description = "The external FQDN of the NGINX auth proxy"
  value       = aws_route53_record.nginx_auth_proxy.fqdn
}

output "http_target_group_arn" {
  description = "The arn of the http target group"
  value       = aws_lb_target_group.alb_target_group_http.arn
}

output "https_target_group_arn" {
  description = "The arn of the http target group"
  value       = aws_lb_target_group.alb_target_group_https.arn
}

output "load_balancer_arn" {
  description = "The arn of the load balancer"
  value       = aws_alb.auth_proxy_alb.arn
}
