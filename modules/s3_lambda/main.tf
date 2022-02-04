data "aws_s3_bucket_object" "file" {
  bucket = var.bucket_name
  key    = "${var.lambda_directory}/${var.filename}.zip"

  provider = aws.parent

  tags = var.tags
}

resource "aws_lambda_function" "lambda" {
  role                           = var.iam_role_arn
  function_name                  = local.function_name
  s3_bucket                      = data.aws_s3_bucket_object.file.bucket
  s3_key                         = data.aws_s3_bucket_object.file.key
  source_code_hash               = lookup(data.aws_s3_bucket_object.file.metadata, "Hash", "Hash not found in S3 Object's metadata")
  handler                        = "${var.filename}.default"
  runtime                        = var.lambda_runtime
  timeout                        = var.timeout
  reserved_concurrent_executions = var.reserved_concurrent_executions
  memory_size                    = var.memory_size

  dynamic "vpc_config" {
    for_each = local.vpc_config
    content {
      subnet_ids         = vpc_config.value.subnet_ids
      security_group_ids = vpc_config.value.security_group_ids
    }
  }

  dynamic "environment" {
    for_each = local.environment_variables
    content {
      variables = environment.value
    }
  }

  tracing_config {
    mode = "PassThrough"
  }

  tags = var.tags
}
