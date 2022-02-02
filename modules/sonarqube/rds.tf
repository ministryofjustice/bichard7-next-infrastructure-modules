resource "random_password" "sonar_db_password" {
  length  = 24
  special = false
}

resource "aws_ssm_parameter" "sonar_db_password" {
  name  = "/sonarqube/rds/db_password"
  type  = "SecureString"
  value = random_password.sonar_db_password.result

  tags = var.tags
}

resource "aws_ssm_parameter" "sonar_db_user" {
  name  = "/sonarqube/rds/db_user"
  type  = "SecureString"
  value = "sonar${random_id.sonar_user_suffix.id}"

  tags = var.tags
}

resource "random_id" "sonar_user_suffix" {
  byte_length = 6
}

resource "random_password" "sonar_admin_user_password" {
  length  = 16
  special = false
}

resource "aws_ssm_parameter" "sonar_admin_user_login" {
  name  = "/sonarqube/rds/sonar_admin_login"
  type  = "SecureString"
  value = "bichard-admin${random_id.sonar_user_suffix.id}"

  tags = var.tags
}

resource "aws_ssm_parameter" "sonar_admin_user_password" {
  name  = "/sonarqube/rds/sonar_admin_password"
  type  = "SecureString"
  value = random_password.sonar_admin_user_password.result

  tags = var.tags
}

# set to count 0 because we are going to set up vpc peering
resource "null_resource" "update_default_username" {
  count = 0
  provisioner "local-exec" {
    interpreter = [
      "/bin/bash",
    "-c"]
    command = <<-EOF
      ./scripts/update_default_username.py \
        ${aws_ssm_parameter.sonar_admin_user_login.value} \
        admin \
        ${aws_route53_record.db_entry.fqdn} \
        sonar \
        ${aws_ssm_parameter.sonar_db_user.value} \
        ${aws_ssm_parameter.sonar_db_password.value}
    EOF
  }
}

# set to count 0 because we are going to set up vpc peering
resource "null_resource" "update_password_for_admin_user" {
  count = 0
  provisioner "local-exec" {
    interpreter = [
      "/bin/bash",
    "-c"]
    command = <<-EOF
      ./scripts/update_password_for_default_user.py \
        ${aws_ssm_parameter.sonar_admin_user_login.value} \
        admin \
        ${aws_ssm_parameter.sonar_admin_user_password.value} \
        ${aws_route53_record.sonar_record.fqdn}
    EOF
  }
}

# tfsec:ignore:aws-rds-enable-performance-insights
resource "aws_db_instance" "sonar_db" {
  identifier               = "sonardb"
  allocated_storage        = 10
  engine                   = "postgres"
  engine_version           = "12.7"
  instance_class           = "db.t3.micro"
  name                     = "sonar"
  username                 = aws_ssm_parameter.sonar_db_user.value
  password                 = random_password.sonar_db_password.result
  skip_final_snapshot      = true
  availability_zone        = "eu-west-2a"
  delete_automated_backups = true
  db_subnet_group_name     = module.vpc.database_subnet_group_name
  storage_encrypted        = true
  backup_retention_period  = 14

  tags = var.tags
}
