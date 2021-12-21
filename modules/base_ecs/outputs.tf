output "cluster_id" {
  description = "The fargate cluster id"
  value       = aws_ecs_cluster.cluster.id
}

output "cluster_name" {
  description = "The fargate cluster name"
  value       = aws_ecs_cluster.cluster.name
}

output "security_group_ids" {
  description = "A map of security group ids"
  value = {
    efs_ingress = aws_security_group.ecs_to_efs.id
  }
}

output "efs_file_system_id" {
  description = "The efs file system id we have created for ecs"
  value       = aws_efs_file_system.ecs_storage.id
}

output "efs_mount_targets" {
  description = "A list of our efs mount target ids"
  value       = aws_efs_mount_target.ecs_storage_subnets.*.id
}

output "bichard_deploy_tag_ssm" {
  description = "The sha256 hash for our docker image"
  value       = aws_ssm_parameter.bichard7_deploy_tag.value
  sensitive   = true
}

output "bichard_deploy_tag_ssm_arn" {
  description = "The arn for the sha256 has for our docker image"
  value       = aws_ssm_parameter.bichard7_deploy_tag.arn
}

output "efs_access_points" {
  description = "Our efs access point"
  value = {
    prometheus = aws_efs_access_point.prometheus_data
  }
}

output "bichard_cluster_kms_key_arn" {
  description = "The ARN of the KMS encryption key"
  value       = aws_kms_key.cluster_logs_encryption_key.arn
}
