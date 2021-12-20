data "aws_caller_identity" "current" {}

data "template_file" "parent_account_ci_policy" {
  template = file("${path.module}/policies/parent_account_ci_policy.json.tpl")
  vars = {
    root_account_id = data.aws_caller_identity.current.account_id
    buckets         = jsonencode(var.buckets)
    bucket_contents = jsonencode(formatlist("%s/*", var.buckets))
  }
}

data "template_file" "allow_codebuild_ci" {
  template = file("${path.module}/policies/allow_codebuild.json.tpl")
  vars = {
    root_account_id = data.aws_caller_identity.current.account_id
  }
}

data "template_file" "allow_assume_administrator_access_template" {
  template = file("${path.module}/policies/allow_assume_parent_admin_access.json.tpl")

  vars = {
    parent_account_id = data.aws_caller_identity.current.account_id
  }
}

data "aws_ssm_parameter" "ci_user" {
  name            = "/users/system/ci"
  with_decryption = true
}
