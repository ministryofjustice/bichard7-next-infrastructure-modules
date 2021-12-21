output "vpc_id" {
  description = "The vpc id"
  value       = module.vpc.vpc_id
}

output "private_subnet_ids" {
  description = "A list of private subnets"
  value       = module.vpc.private_subnets
}

output "private_subnet_cidrs" {
  description = "A list of private cidr blocks"
  value       = module.vpc.private_subnets_cidr_blocks
}

output "vpc_endpoint_s3_prefix_list_id" {
  description = "The id for the s3 prefix list"
  value       = module.vpc_endpoints.endpoints.*.s3[0].prefix_list_id
}

output "vpc_endpoint_dynamodb_prefix_list_id" {
  description = "The id for the dynamodb prefix list"
  value       = module.vpc_endpoints.endpoints.*.dynamodb[0].prefix_list_id
}

output "security_group_ids" {
  description = "A map of security group ids"
  value = {
    vpc_endpoints = aws_security_group.vpc_endpoints.id
  }
}

output "vpc_endpoints" {
  description = "A map of our vpc endpoints"
  value       = module.vpc_endpoints.endpoints
}
