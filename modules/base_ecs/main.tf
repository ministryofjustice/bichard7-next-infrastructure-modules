resource "aws_kms_key" "cluster_logs_encryption_key" {
  deletion_window_in_days = 7
  enable_key_rotation     = true

  tags = var.tags
}

resource "aws_kms_alias" "cluster_logs_encryption_key" {
  target_key_id = aws_kms_key.cluster_logs_encryption_key.arn
  name          = "alias/${local.cluster_name}-ecs-log-encryption"
}

resource "aws_iam_role_policy" "allow_admin_role_cmk_access" {
  name = "${local.cluster_name}-allow-admin-cmk-access"

  policy = data.template_file.allow_admin_cmk_access.rendered
  role   = data.aws_iam_role.admin_role.name
}

resource "aws_ecs_cluster" "cluster" {
  name = local.cluster_name

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
        cloud_watch_log_group_name     = var.log_group_name
      }
    }
  }

  tags = var.tags
}

resource "aws_ssm_parameter" "bichard7_deploy_tag" {
  name      = "/${var.name}/bichard7/deploy-tag"
  type      = "SecureString"
  value     = var.bichard_deploy_tag
  overwrite = var.override_deploy_tags

  tags = var.tags
}
