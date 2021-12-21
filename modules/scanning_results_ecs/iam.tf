resource "aws_iam_user" "scanning_bucket_user" {
  name = "scanning.results.reader"
  path = "/system/"
  tags = var.tags
}

resource "random_password" "scanning_portal_password" {
  length  = 24
  special = false
}

resource "aws_iam_access_key" "scanning_bucket_user" {
  user = aws_iam_user.scanning_bucket_user.name
}

resource "aws_ssm_parameter" "scanning_bucket_access_key" {
  name  = "/system/scanning/key"
  type  = "SecureString"
  value = aws_iam_access_key.scanning_bucket_user.id

  tags = var.tags
}

resource "aws_ssm_parameter" "scanning_bucket_secret_key" {
  name  = "/system/scanning/secret"
  type  = "SecureString"
  value = aws_iam_access_key.scanning_bucket_user.secret

  tags = var.tags
}

resource "aws_ssm_parameter" "scanning_portal_username" {
  name  = "/system/scanning/username"
  type  = "SecureString"
  value = "bichard"

  tags = var.tags
}

resource "aws_ssm_parameter" "scanning_portal_password" {
  name  = "/system/scanning/password"
  type  = "SecureString"
  value = random_password.scanning_portal_password.result

  tags = var.tags
}

# tfsec:ignore:aws-iam-no-policy-wildcards
resource "aws_iam_user_policy" "scanning_user_policy" {
  name   = "AllowScanningBucketAccess"
  user   = aws_iam_user.scanning_bucket_user.name
  policy = <<-EOF
  {
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "s3:GetObjectAcl",
                "s3:GetObject",
                "s3:ListBucketVersions",
                "s3:GetObjectVersionAcl",
                "s3:ListBucket",
                "s3:GetBucketPolicy",
                "s3:GetObjectVersion"
            ],
            "Resource": [
                "arn:aws:s3:::${var.scanning_bucket_name}/*",
                "arn:aws:s3:::${var.scanning_bucket_name}"
            ]
        },
        {
            "Effect": "Allow",
            "Action": "s3:ListAllMyBuckets",
            "Resource": "*"
        }
    ]
  }
  EOF
}

resource "aws_kms_key" "cloudwatch_encryption" {
  description = "${var.name}-cloudwatch-encryption"

  enable_key_rotation     = true
  deletion_window_in_days = 7

  policy = <<-EOF
  {
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "Enable IAM User Permissions",
      "Effect": "Allow",
      "Principal": {
        "AWS": [
          "arn:aws:iam::${data.aws_caller_identity.current.account_id}:root",
          "arn:aws:iam::${data.aws_caller_identity.current.account_id}:user/system/cjse.ci",
          "${aws_iam_user.scanning_bucket_user.arn}"
        ]
      },
      "Action": "kms:*",
      "Resource": "*"
    },
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "logs.${data.aws_region.current.name}.amazonaws.com"
      },
      "Action": [
        "kms:Encrypt*",
        "kms:Decrypt*",
        "kms:ReEncrypt*",
        "kms:GenerateDataKey*",
        "kms:Describe*"
      ],
      "Resource": "*",
      "Condition": {
        "ArnEquals": {
          "kms:EncryptionContext:aws:logs:arn": "arn:aws:logs:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:*"
        }
      }
    }
  ]
}
  EOF

  tags = var.tags
}

resource "aws_kms_alias" "cloudwatch_kms_alias" {
  target_key_id = aws_kms_key.cloudwatch_encryption.arn
  name          = "alias/${aws_kms_key.cloudwatch_encryption.description}"
}
