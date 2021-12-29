resource "aws_s3_bucket" "vpc_flow_logs_bucket" {
  bucket = "${var.name}-codebuild-flow-logs"
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
    target_prefix = "postfix-vpc-flow-logs/"
  }

  tags = var.tags
}


resource "aws_s3_bucket_public_access_block" "vpc_flow_logs_bucket" {
  bucket                  = aws_s3_bucket.vpc_flow_logs_bucket.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}
