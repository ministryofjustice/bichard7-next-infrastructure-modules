data "aws_caller_identity" "current" {}

data "aws_iam_role" "admin_role" {
  name = "Bichard7-Administrator-Access"
}

data "template_file" "allow_admin_cmk_access" {
  template = file("${path.module}/policies/allow_admin_cmk_access.json.tpl")

  vars = {
    kms_key_arn = aws_kms_key.cluster_logs_encryption_key.arn
  }
}
