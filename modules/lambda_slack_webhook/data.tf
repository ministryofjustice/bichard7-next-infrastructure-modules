data "aws_caller_identity" "current" {}

data "aws_region" "current" {}

data "aws_ssm_parameter" "slack_webhook" {
  name            = "/lambda/slack/webhook"
  with_decryption = true
}

data "archive_file" "slack_webhook_notification" {
  output_path = "/tmp/slack_webhook_notification_rule.zip"
  type        = "zip"

  source {
    content = templatefile("${path.module}/source/webhook.py.tpl", {
      webhook_url                = data.aws_ssm_parameter.slack_webhook.value
      notifications_channel_name = var.notifications_channel_name
    })
    filename = "webhook.py"
  }
}
