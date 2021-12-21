resource "aws_kms_key" "efs_encryption_key" {
  description             = "${var.name} key"
  deletion_window_in_days = 10
  enable_key_rotation     = true

  tags = var.tags
}

resource "aws_kms_alias" "aurora_cluster_encryption_key_alias" {
  target_key_id = aws_kms_key.efs_encryption_key.arn
  name          = "alias/${var.name}-efs-encryption"
}

resource "aws_efs_file_system" "ecs_storage" {
  encrypted  = true
  kms_key_id = aws_kms_key.efs_encryption_key.arn

  lifecycle_policy {
    transition_to_ia = "AFTER_30_DAYS"
  }

  tags = var.tags
}

resource "aws_efs_mount_target" "ecs_storage_subnets" {
  count          = length(var.service_subnets)
  file_system_id = aws_efs_file_system.ecs_storage.id
  subnet_id      = element(var.service_subnets, count.index)
  security_groups = [
    aws_security_group.ecs_to_efs.id
  ]
}

resource "aws_efs_access_point" "prometheus_data" {
  file_system_id = aws_efs_file_system.ecs_storage.id

  posix_user {
    gid = 0
    uid = 0
    secondary_gids = [
      99,  # Nobody
      999, # Normal GID for created user
      1000 # Normal GID for created user
    ]
  }

  root_directory {
    path = "/prometheus"
    creation_info {
      owner_gid   = 0
      owner_uid   = 0
      permissions = "0777"
    }
  }
}
