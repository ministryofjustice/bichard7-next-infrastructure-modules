# tfsec:ignore:aws-iam-no-user-attached-policies
resource "aws_iam_user" "s3_web_proxy_user" {
  name = "${var.service_id}.user"
  path = "/system/"

  tags = var.tags
}

resource "random_password" "s3_web_proxy_password" {
  length  = 24
  special = false
}

resource "aws_iam_access_key" "s3_web_proxy_access_key" {
  user = aws_iam_user.s3_web_proxy_user.name
}

resource "aws_ssm_parameter" "s3_web_proxy_access_key" {
  name  = "/system/${var.service_id}/key"
  type  = "SecureString"
  value = aws_iam_access_key.s3_web_proxy_access_key.id

  tags = var.tags
}

resource "aws_ssm_parameter" "s3_web_proxy_secret_key" {
  name  = "/system/${var.service_id}/secret"
  type  = "SecureString"
  value = aws_iam_access_key.s3_web_proxy_access_key.secret

  tags = var.tags
}

# tfsec:ignore:aws-iam-no-policy-wildcards
resource "aws_iam_user_policy" "s3_web_proxy_user_policy" {
  name   = "AllowScanningBucketAccess"
  user   = aws_iam_user.s3_web_proxy_user.name
  policy = data.template_file.web_proxy_user_policy.rendered
}

resource "aws_kms_key" "cloudwatch_encryption" {
  description = "${var.name}-cloudwatch-encryption"

  enable_key_rotation     = true
  deletion_window_in_days = 7

  policy = data.template_file.allow_cloudwatch_kms.rendered

  tags = var.tags
}

resource "aws_kms_alias" "cloudwatch_kms_alias" {
  target_key_id = aws_kms_key.cloudwatch_encryption.arn
  name          = "alias/${aws_kms_key.cloudwatch_encryption.description}"
}
