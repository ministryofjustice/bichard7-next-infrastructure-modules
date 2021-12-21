resource "aws_kms_key" "cluster_logs_encryption_key" {
  deletion_window_in_days = 7
  enable_key_rotation     = true

  tags = var.tags
}

resource "aws_kms_alias" "cluster_logs_encryption_key" {
  target_key_id = aws_kms_key.cluster_logs_encryption_key.arn
  name          = "alias/${var.name}-log-encryption"
}

resource "aws_iam_role_policy" "allow_admin_role_cmk_access" {
  policy = data.template_file.allow_cmk_admin_access.rendered
  role   = data.aws_iam_role.admin_role.name
}

resource "aws_ecs_cluster" "monitoring_cluster" {
  name = "${var.name}-monitoring"

  setting {
    name  = "containerInsights"
    value = "enabled"
  }

  configuration {
    execute_command_configuration {
      kms_key_id = aws_kms_key.cluster_logs_encryption_key.arn
      logging    = "OVERRIDE"

      log_configuration {
        cloud_watch_encryption_enabled = true
        cloud_watch_log_group_name     = var.prometheus_log_group.name
      }
    }
  }

  tags = var.tags
}
