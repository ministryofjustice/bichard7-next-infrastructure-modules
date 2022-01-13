output "postfix_vpc" {
  description = "The outputs from our postfix VPC"
  value       = module.postfix_vpc
}

output "postfix_vpc_nat_gateway_ip" {
  description = "The ips of our external nat gateway, this will be presented to cjsm"
  value       = module.postfix_vpc.nat_public_ips
}

output "postfix_vpce_security_group_id" {
  description = "The id of the vpce"
  value       = aws_security_group.postfix_vpce.id
}

output "postfix_vpce_service" {
  description = "The vpce service we are going to consume in the application"
  value       = aws_vpc_endpoint_service.postfix
}
