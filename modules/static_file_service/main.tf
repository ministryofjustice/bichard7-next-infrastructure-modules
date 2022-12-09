#tfsec:ignore:aws-s3-encryption-customer-key
resource "aws_s3_bucket" "static_file_bucket" {
  bucket = local.static_files_bucket_name
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
    target_bucket = var.logging_bucket_name
    target_prefix = "static-file-logs/"
  }

  tags = var.tags
}

resource "aws_s3_bucket_policy" "static_file_bucket" {
  bucket = aws_s3_bucket.static_file_bucket.bucket
  policy = data.template_file.static_file_bucket.rendered
}

resource "aws_s3_bucket_public_access_block" "static_file_bucket" {
  bucket = aws_s3_bucket.static_file_bucket.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

module "static_file_service" {
  source = "github.com/ministryofjustice/bichard7-next-infrastructure-modules.git//modules/s3_web_proxy"

  fargate_cpu         = 2048
  fargate_memory      = 4096
  logging_bucket_name = var.logging_bucket_name
  name                = var.name
  public_zone_id      = var.public_zone_id
  service_subnets     = var.service_subnets
  ssl_certificate_arn = var.ssl_certificate_arn
  vpc_id              = var.vpc_id
  bucket_name         = aws_s3_bucket.static_file_bucket.bucket
  tags                = var.tags
  service_id          = "${var.tags["workspace"]}-static-files"
  s3_web_proxy_image  = var.s3_web_proxy_image
  s3_web_proxy_arn    = var.s3_web_proxy_arn
  parent_account_id   = var.parent_account_id
}
