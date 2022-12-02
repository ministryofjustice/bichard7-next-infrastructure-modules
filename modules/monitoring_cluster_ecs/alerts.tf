### Lambda
resource "aws_iam_role" "scanning_notification" {
  name               = "${var.name}-AllowAlertNotifications"
  assume_role_policy = file("${path.module}/policies/allow_alerts_notification.json")

  tags = var.tags
}

resource "aws_lambda_function" "prometheus_alerts" {
  count = local.provision_alerts

  function_name = "${var.name}-prometheus-alert"
  description   = "Allow prometheus payload to be parsed from SNS"

  filename         = data.archive_file.alert_archive.output_path
  source_code_hash = data.archive_file.alert_archive.output_base64sha256
  handler          = "alert.lambda_handler"

  role        = aws_iam_role.scanning_notification.arn
  memory_size = "128"
  runtime     = "python3.8"
  timeout     = "5"

  tracing_config {
    mode = "PassThrough"
  }

  tags = var.tags
}

resource "aws_lambda_permission" "prometheus_alerts" {
  count = local.provision_alerts

  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.prometheus_alerts[count.index].function_name
  principal     = "sns.amazonaws.com"
  source_arn    = var.sns_alert_notifications_arn
}

resource "aws_sns_topic_subscription" "prometheus_alerts_subscription" {
  count     = local.provision_alerts
  endpoint  = aws_lambda_function.prometheus_alerts[count.index].arn
  protocol  = "lambda"
  topic_arn = var.sns_alert_notifications_arn
}

# tfsec:ignore:aws-iam-no-policy-wildcards
resource "aws_iam_policy" "prometheus_alerts_logging" {
  name        = "${var.name}-AllowAlertLambdaLogging"
  path        = "/"
  description = "IAM policy for logging from a lambda"
  policy      = file("${path.module}/policies/allow_lambda_logging.json")

  tags = var.tags
}

resource "aws_iam_role_policy_attachment" "scanning_lambda_logs" {
  role       = aws_iam_role.scanning_notification.name
  policy_arn = aws_iam_policy.prometheus_alerts_logging.arn
}
