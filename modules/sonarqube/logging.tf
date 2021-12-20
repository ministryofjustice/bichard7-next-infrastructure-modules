resource "aws_cloudwatch_log_group" "sonar_log_group" {
  name       = "${var.environment}-sonar"
  kms_key_id = aws_kms_key.cloudwatch_encryption.arn

  tags = var.tags
}

resource "aws_cloudwatch_log_stream" "sonar_log_stream" {
  name           = "${var.name}-sonar"
  log_group_name = aws_cloudwatch_log_group.sonar_log_group.name
}
