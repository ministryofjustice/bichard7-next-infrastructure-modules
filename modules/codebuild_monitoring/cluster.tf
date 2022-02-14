#resource "aws_kms_key" "cluster_logs_encryption_key" {
#  deletion_window_in_days = 7
#  enable_key_rotation     = true
#
#  tags = var.tags
#}
#
#resource "aws_kms_alias" "cluster_logs_encryption_key" {
#  target_key_id = aws_kms_key.cluster_logs_encryption_key.arn
#  name          = "alias/${var.name}-log-encryption"
#}
#
#resource "aws_ecs_cluster" "monitoring_cluster" {
#  name = "${var.name}-codebuild-grafana"
#
#  setting {
#    name  = "containerInsights"
#    value = "enabled"
#  }
#
#  configuration {
#    execute_command_configuration {
#      kms_key_id = aws_kms_key.cluster_logs_encryption_key.arn
#      logging    = "OVERRIDE"
#
#      log_configuration {
#        cloud_watch_encryption_enabled = true
#        cloud_watch_log_group_name     = aws_cloudwatch_log_group.codebuild_monitoring.name
#      }
#    }
#  }
#
#  tags = var.tags
#}
