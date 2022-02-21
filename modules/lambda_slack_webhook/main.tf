resource "aws_kms_key" "slack_webhook_notifications_key" {
  description             = "${var.name}-slack-webhook-notifications-encryption-key"
  enable_key_rotation     = true
  deletion_window_in_days = 10
  policy = templatefile("${path.module}/policies/allow_cloudwatch_kms.json.tpl", {
    region     = data.aws_region.current.name
    account_id = data.aws_caller_identity.current.account_id
  })

  tags = var.tags
}

resource "aws_kms_alias" "slack_webhook_notifications_key_alias" {
  name          = "alias/slack-webhook-notifications"
  target_key_id = aws_kms_key.slack_webhook_notifications_key.arn
}

resource "aws_sns_topic" "slack_webhook_notifications" {
  name              = "${var.name}-slack-webhook-notifications"
  display_name      = title(replace("${var.name}-slack-webhook-notifications", "-", " "))
  kms_master_key_id = aws_kms_key.slack_webhook_notifications_key.arn

  tags = var.tags
}

resource "aws_sns_topic_policy" "default" {
  arn = aws_sns_topic.slack_webhook_notifications.arn
  policy = templatefile("${path.module}/policies/allow_sns_policy.json.tpl", {
    sns_topic_arn = aws_sns_topic.slack_webhook_notifications.arn
    account_id    = data.aws_caller_identity.current.account_id
  })
}

resource "aws_iam_role" "slack_webhook_notification" {
  name               = "AllowSlackWebhookNotifications"
  assume_role_policy = file("${path.module}/policies/allow_slack_webhook_notification.json")

  tags = var.tags
}

resource "aws_lambda_function" "slack_webhook_notification" {
  function_name = "${var.name}-slack-webhook-notifications"
  description   = "Allow sns notifications to push to a webhook"

  filename         = data.archive_file.slack_webhook_notification.output_path
  source_code_hash = data.archive_file.slack_webhook_notification.output_base64sha256
  handler          = "webhook.lambda_handler"

  role        = aws_iam_role.slack_webhook_notification.arn
  memory_size = "128"
  runtime     = "python3.8"
  timeout     = "5"

  tracing_config {
    mode = "PassThrough"
  }

  tags = var.tags
}

resource "aws_lambda_permission" "slack_webhook_notification" {
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.slack_webhook_notification.function_name
  principal     = "sns.amazonaws.com"
  source_arn    = aws_sns_topic.slack_webhook_notifications.arn
}

resource "aws_sns_topic_subscription" "slack_webhook_subscription" {
  endpoint  = aws_lambda_function.slack_webhook_notification.arn
  protocol  = "lambda"
  topic_arn = aws_sns_topic.slack_webhook_notifications.arn
}
