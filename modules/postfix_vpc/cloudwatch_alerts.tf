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
  namespace           = "${var.name}/smtp"
  treat_missing_data  = "ignore"

  alarm_actions = [
    var.cloudwatch_notifications_arn
  ]
  ok_actions = [
    var.cloudwatch_notifications_arn
  ]
  actions_enabled = true

  dimensions = {
    host = substr("mail${count.index + 1}.${data.aws_route53_zone.public.name}", 0, 65)
    cpu  = "cpu0"
  }

  tags = var.tags
}

resource "aws_cloudwatch_metric_alarm" "memory_usage" {
  count = length(module.postfix_vpc.private_subnets)

  alarm_name          = "postfix${count.index + 1}-memory-usage"
  alarm_description   = "Memory Usage on ${aws_instance.postfix[count.index].tags["Name"]} greater than threshold %"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 5
  threshold           = 70
  treat_missing_data  = "ignore"

  metric_query {
    id          = "e1"
    expression  = "(m1/m2)*100"
    label       = "Memory Used Percentage"
    return_data = "true"
  }

  metric_query {
    id = "m1"

    metric {
      metric_name = "mem_used"
      namespace   = "${var.name}/smtp"
      period      = 60
      stat        = "Average"

      dimensions = {
        host = substr("mail${count.index + 1}.${data.aws_route53_zone.public.name}", 0, 65)
      }
    }
  }

  metric_query {
    id = "m2"

    metric {
      metric_name = "mem_total"
      namespace   = "${var.name}/smtp"
      period      = 60
      stat        = "Average"

      dimensions = {
        host = substr("mail${count.index + 1}.${data.aws_route53_zone.public.name}", 0, 65)
      }
    }
  }

  tags = var.tags
}
