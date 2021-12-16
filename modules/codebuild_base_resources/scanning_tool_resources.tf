resource "aws_s3_bucket" "scanning_results_bucket" {
  bucket = "${var.name}-scanning-results"
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
    target_prefix = "scanning-results/"
  }

  tags = var.tags
}

resource "aws_s3_bucket_public_access_block" "scanning_results_bucket" {
  bucket = aws_s3_bucket.scanning_results_bucket.bucket

  block_public_acls       = true
  ignore_public_acls      = true
  block_public_policy     = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_policy" "allow_access_to_scanning_results_bucket" {
  bucket = aws_s3_bucket.scanning_results_bucket.bucket

  policy = <<-EOF
  {
      "Version": "2012-10-17",
      "Statement": [
          {
              "Sid": "ListObjectsInBucket",
              "Effect": "Allow",
              "Action": [
                  "s3:ListBucket"
              ],
              "Resource": "${aws_s3_bucket.scanning_results_bucket.arn}",
              "Principal": {
                "AWS": ${jsonencode(sort(formatlist("arn:aws:iam::%s:root", var.allow_accounts)))}
              }
          },
          {
              "Sid": "AllObjectActions",
              "Effect": "Allow",
              "Action": [
                "s3:*Object",
                "s3:*ObjectAcl"
              ],
              "Resource": ["${aws_s3_bucket.scanning_results_bucket.arn}/*"],
               "Principal": {
                "AWS": ${jsonencode(sort(formatlist("arn:aws:iam::%s:root", var.allow_accounts)))}
              }
          },
          {
              "Sid": "AllActions",
              "Effect": "Allow",
              "Action": "s3:*",
              "Resource": [
                  "${aws_s3_bucket.scanning_results_bucket.arn}/*",
                  "${aws_s3_bucket.scanning_results_bucket.arn}"
              ],
             "Principal": {
              "AWS": [
                "arn:aws:iam::${data.aws_caller_identity.current.account_id}:root",
                "${data.aws_iam_user.ci_user.arn}"
              ]
            }
          }
      ]
  }
  EOF
}
