resource "aws_s3_bucket" "codebuild_artifact_bucket" {
  bucket = "${var.name}-codebuild"
  acl    = "private"

  force_destroy = true

  versioning {
    enabled = true
  }

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }

  logging {
    target_bucket = var.aws_logs_bucket
    target_prefix = "codebuild/"
  }

  tags = var.tags
}

resource "aws_s3_bucket_public_access_block" "codebuild_artifact_bucket" {
  bucket = aws_s3_bucket.codebuild_artifact_bucket.bucket

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

locals {
  child_accounts = compact([for x in var.allow_accounts : x == data.aws_caller_identity.current.account_id ? "" : x])
  cidr_block     = ((var.vpc_cidr_block == null) ? "10.0.0.0/16" : var.vpc_cidr_block)
}

resource "aws_s3_bucket_policy" "allow_access_to_codebuild_bucket" {
  bucket = aws_s3_bucket.codebuild_artifact_bucket.bucket

  policy = <<-EOF
  {
    "Version": "2012-10-17",
    "Statement": [
      {
        "Sid": "ListObjectsInBucket",
        "Effect": "Allow",
        "Action": [
          "s3:ListBucket",
          "s3:GetBucketAcl",
          "s3:ListBucketVersions",
          "s3:GetBucketVersioning",
          "s3:GetBucketPublicAccessBlock"
        ],
        "Resource": ["${aws_s3_bucket.codebuild_artifact_bucket.arn}"],
        "Principal": {
          "AWS": ${jsonencode(sort(concat(formatlist("arn:aws:iam::%s:root", var.allow_accounts), formatlist("arn:aws:iam::%s:role/Bichard7-CI-Access", local.child_accounts))))}
        }
      },
      {
        "Sid": "AllObjectActions",
        "Effect": "Allow",
        "Action": [
          "s3:*Object",
          "s3:GetObjectAcl",
          "s3:GetObjectVersion",
          "s3:GetObjectVersionAcl"
        ],
        "Resource": ["${aws_s3_bucket.codebuild_artifact_bucket.arn}/*"],
        "Principal": {
          "AWS": ${jsonencode(sort(concat(formatlist("arn:aws:iam::%s:root", var.allow_accounts), formatlist("arn:aws:iam::%s:role/Bichard7-CI-Access", local.child_accounts))))}
        }
      },
      {
        "Sid": "LambdaGet",
        "Effect": "Allow",
        "Action": [
          "s3:Get*",
          "s3:ListBucket",
          "s3:GetObjectAcl",
          "s3:GetObjectVersion",
          "s3:GetObjectVersionAcl",
          "s3:ListBucketVersions",
          "s3:GetBucketVersioning"
        ],
        "Resource": [
          "${aws_s3_bucket.codebuild_artifact_bucket.arn}/*",
          "${aws_s3_bucket.codebuild_artifact_bucket.arn}"
        ],
        "Principal": {
          "AWS": ${jsonencode(sort(concat(formatlist("arn:aws:iam::%s:role/portal-host-lambda-role", local.child_accounts), formatlist("arn:aws:iam::%s:role/Bichard7-CI-Access", local.child_accounts))))}
        }
      },
      {
        "Sid": "AllActions",
        "Effect": "Allow",
        "Action": "s3:*",
        "Resource": ["${aws_s3_bucket.codebuild_artifact_bucket.arn}/*"],
        "Principal": {
          "AWS": "arn:aws:iam::${data.aws_caller_identity.current.account_id}:root"
        }
      },
      {
        "Sid": "AllActionsCodeBuild",
        "Effect": "Allow",
        "Action": "s3:*",
        "Resource": [
          "${aws_s3_bucket.codebuild_artifact_bucket.arn}/*",
          "${aws_s3_bucket.codebuild_artifact_bucket.arn}"
        ],
        "Principal": {
          "AWS": "${data.aws_iam_user.ci_user.arn}"
        }
      },
      {
          "Sid": "AWSCloudTrailRead",
          "Effect": "Allow",
          "Action": "s3:GetObject*",
          "Principal": {
            "Service": "cloudtrail.amazonaws.com"
          },
          "Resource": [
            "${aws_s3_bucket.codebuild_artifact_bucket.arn}/semaphores/*"
          ]
      },
      {
          "Effect": "Allow",
          "Principal": {
              "Service": "cloudtrail.amazonaws.com"
          },
          "Action": "s3:GetBucketAcl",
          "Resource": "${aws_s3_bucket.codebuild_artifact_bucket.arn}"
      },
      {
          "Effect": "Allow",
          "Principal": {
              "Service": "cloudtrail.amazonaws.com"
          },
          "Action": "s3:PutObject",
          "Resource": "${aws_s3_bucket.codebuild_artifact_bucket.arn}/AWSLogs/${data.aws_caller_identity.current.account_id}/*",
          "Condition": {
              "StringEquals": {
                  "s3:x-amz-acl": "bucket-owner-full-control"
              }
          }
      }
    ]
  }
  EOF
}

resource "aws_dynamodb_table" "codebuild_lock_table" {
  hash_key       = "project_name"
  name           = "${var.name}-codebuild-concurrency"
  read_capacity  = 20
  write_capacity = 20

  point_in_time_recovery {
    enabled = true
  }

  server_side_encryption {
    enabled = true
  }

  attribute {
    name = "project_name"
    type = "S"
  }

  attribute {
    name = "expire_at"
    type = "N"
  }

  attribute {
    name = "lock_token"
    type = "S"
  }

  global_secondary_index {
    name               = "ExpireAtIndex"
    hash_key           = "expire_at"
    range_key          = "lock_token"
    write_capacity     = 10
    read_capacity      = 10
    projection_type    = "INCLUDE"
    non_key_attributes = ["project_name"]
  }

  tags = var.tags
}

resource "aws_iam_user_policy" "allow_lock_table_access" {
  name = "AllowCIConcurrency"
  user = data.aws_iam_user.ci_user.user_name

  policy = <<-EOF
  {
    "Version": "2012-10-17",
    "Statement": [
      {
        "Effect": "Allow",
        "Action": [
            "dynamodb:DeleteItem",
            "dynamodb:DescribeTable",
            "dynamodb:GetItem",
            "dynamodb:PutItem",
            "dynamodb:Query",
            "dynamodb:Scan",
            "dynamodb:UpdateItem",
            "dynamodb:DescribeTimeToLive"
        ],
        "Resource": [
            "${aws_dynamodb_table.codebuild_lock_table.arn}"
        ]
      }
    ]
  }
  EOF
}
