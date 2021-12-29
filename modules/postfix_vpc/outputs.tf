output "postfix_vpc" {
  description = "The outputs from our postfix VPC"
  value       = module.postfix_vpc
}

output "instance_ipv4_address" {
  description = "The static private IPV4 addresses of our postfix instance"
  value       = aws_network_interface.static_ip.*.private_ip
}

output "instance_ipv4_cidr" {
  description = "The static private IPV4 addresses of our postfix instance in cidr notation"
  value       = formatlist("%s/32", aws_network_interface.static_ip.*.private_ip)
}

output "postfix_vpc_nat_gateway_ip" {
  description = "The ips of our external nat gateway, this will be presented to cjsm"
  value       = module.postfix_vpc.nat_public_ips
}

output "postfix_instance_profile_arn" {
  description = "The arn of our postfix instance profile"
  value       = aws_iam_instance_profile.postfix_instance_profile.arn
}

output "postfix_vpce_security_group_id" {
  description = "The id of the vpce"
  value       = aws_security_group.postfix_vpce.id
}

output "postfix_vpce_service" {
  description = "The vpce service we are going to consume in the application"
  value       = aws_vpc_endpoint_service.postfix
}
