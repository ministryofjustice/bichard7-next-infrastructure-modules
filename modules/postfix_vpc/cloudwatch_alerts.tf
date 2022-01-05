resource "aws_cloudwatch_metric_alarm" "cpu_usage" {
  count = length(module.postfix_vpc.private_subnets)

  alarm_name          = "postfix${count.index + 1}-cpu-usage"
  alarm_description   = "CPU Usage on ${aws_instance.postfix[count.index].tags["Name"]} greater than threshold %"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 5
  period              = 60
  statistic           = "Average"
  threshold           = 70
  metric_name         = "cpu_usage_nice"
  namespace           = "CWAgent"
  treat_missing_data  = "ignore"

  alarm_actions = [
    var.cloudwatch_notifications_arn
  ]
  ok_actions = [
    var.cloudwatch_notifications_arn
  ]
  actions_enabled = true

  dimensions = {
    InstanceId = aws_instance.postfix[count.index].id
    cpu        = "cpu0"
  }

  tags = var.tags
}
