resource "aws_s3_bucket" "snapshot" {
  bucket = "${var.name}-opensearch-snapshots"
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
    target_prefix = "${var.name}-opensearch-snapshots/"
  }

  tags = var.tags
}

resource "aws_s3_bucket_public_access_block" "snapshot" {
  bucket                  = aws_s3_bucket.snapshot.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_iam_role" "snapshot_create" {
  name               = "${var.name}-opensearch-snapshot-s3put"
  description        = "Role used by OpenSearch to put to s3"
  assume_role_policy = file("${path.module}/policies/es_assume_role.json")

  tags = var.tags
}

resource "aws_iam_role_policy" "snapshot_create_policy" {
  role   = aws_iam_role.snapshot_create.id
  policy = data.template_file.snapshot_s3_policy.rendered
}

## Lambdas
resource "aws_iam_role" "snapshot_lambda" {
  name               = "${var.name}-opensearch-snapshot-lambda"
  description        = "Role for the OpenSearch snapshot Lambda function"
  assume_role_policy = file("${path.module}/policies/lambda_assume_role.json")

  tags = var.tags
}

resource "aws_iam_role_policy" "snapshot_lambda" {
  role   = aws_iam_role.snapshot_lambda.id
  policy = data.template_file.snapshot_s3_lambda_policy.rendered
}

resource "aws_lambda_function" "snapshot_lambda" {
  function_name = local.lambda_function_name
  description   = "Function to create S3-based OpenSearch snapshots"

  runtime          = "python3.8"
  handler          = "snapshot.lambda_handler"
  filename         = "${path.module}/snapshot_lambda.zip"
  source_code_hash = filebase64sha256("${path.module}/snapshot_lambda.zip")
  role             = aws_iam_role.snapshot_lambda.arn
  timeout          = 900
  memory_size      = 4096

  environment {
    variables = {
      BUCKET        = aws_s3_bucket.snapshot.id
      HOST          = aws_elasticsearch_domain.es.endpoint
      REGION        = data.aws_region.current.name
      REPOSITORY    = "s3-manual"
      RETENTION     = var.s3_snapshots_retention_period
      ROLE_ARN      = aws_iam_role.snapshot_create.arn
      SSM_USER_PATH = aws_ssm_parameter.es_user.name
      SSM_PASS_PATH = aws_ssm_parameter.es_password.name
    }
  }

  vpc_config {
    security_group_ids = [
      data.aws_security_group.snapshot_lambda.id
    ]
    subnet_ids = var.service_subnets
  }

  tracing_config {
    mode = "PassThrough"
  }

  tags = var.tags
}

resource "aws_cloudwatch_event_rule" "snapshot_lambda" {
  name                = "${var.name}-opensearch-snapshot-rule"
  tags                = var.tags
  schedule_expression = var.s3_snapshots_schedule_expression
}

resource "aws_cloudwatch_event_target" "snapshot_lambda" {
  rule      = aws_cloudwatch_event_rule.snapshot_lambda.name
  target_id = "${var.name}-opensearch-snapshot-rule"
  arn       = aws_lambda_function.snapshot_lambda.arn
}

resource "aws_lambda_permission" "snapshot_lambda" {
  statement_id  = "AllowExecutionFromCloudWatch"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.snapshot_lambda.arn
  principal     = "events.amazonaws.com"
  source_arn    = aws_cloudwatch_event_rule.snapshot_lambda.arn
}
