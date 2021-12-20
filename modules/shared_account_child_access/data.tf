data "aws_caller_identity" "current" {}

data "aws_region" "current_region" {}

data "template_file" "ci_to_parent_policy_template" {
  template = file("${path.module}/policies/child_to_parent_policy.json.tpl")
  vars = {
    parent_account_id = var.root_account_id
    bucket_name       = var.bucket_name
    logging_bucket    = var.logging_bucket_name
  }
}

data "template_file" "ci_policy_document_part1" {
  template = file("${path.module}/policies/child_ci_policy_part1.json.tpl")
  vars = {
    parent_account_id = var.root_account_id
    account_id        = data.aws_caller_identity.current.account_id
    bucket_name       = var.bucket_name
    region            = data.aws_region.current_region.name
  }
}

data "template_file" "ci_policy_document_part2" {
  template = file("${path.module}/policies/child_ci_policy_part2.json.tpl")
  vars = {
    parent_account_id = var.root_account_id
    account_id        = data.aws_caller_identity.current.account_id
    bucket_name       = var.bucket_name
    region            = data.aws_region.current_region.name
  }
}

data "template_file" "allow_assume_ci_access_template" {
  template = file("${path.module}/policies/allow_assume_ci_access.json.tpl")

  vars = {
    parent_account_id = var.root_account_id
  }
}

data "template_file" "allow_assume_administrator_access_template" {
  template = file("${path.module}/policies/${local.access_template}")

  vars = {
    parent_account_id = var.root_account_id
    excluded_arns     = jsonencode(var.denied_user_arns)
  }
}

data "template_file" "allow_assume_readonly_access_template" {
  template = file("${path.module}/policies/${local.access_template}")

  vars = {
    parent_account_id = var.root_account_id
    excluded_arns     = jsonencode(var.denied_user_arns)
  }
}

data "template_file" "deny_non_tls_s3_comms_on_logging_bucket" {
  template = file("${path.module}/policies/non_tls_comms_on_bucket_policy.json.tpl")

  vars = {
    bucket_arn = aws_s3_bucket.account_logging_bucket.arn
  }
}
