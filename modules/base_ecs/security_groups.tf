resource "aws_security_group" "ecs_to_efs" {
  description = "Allow our ecs cluster access to efs"

  name   = local.efs_name
  vpc_id = var.vpc_id

  tags = var.tags
}
