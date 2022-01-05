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
    host = substr("mail${count.index + 1}.${data.aws_route53_zone.public.name}", 0, 64)
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
        host = substr("mail${count.index + 1}.${data.aws_route53_zone.public.name}", 0, 64)
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
        host = substr("mail${count.index + 1}.${data.aws_route53_zone.public.name}", 0, 64)
      }
    }
  }

  tags = var.tags
}


resource "aws_cloudwatch_metric_alarm" "percentage_disk_used" {
  count = length(module.postfix_vpc.private_subnets)

  alarm_name          = "postfix${count.index + 1}-percentage-disk-used"
  alarm_description   = "Disk space free on root for ${aws_instance.postfix[count.index].tags["Name"]} greater than threshold %"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 5
  threshold           = 70
  treat_missing_data  = "ignore"

  metric_query {
    id          = "e1"
    expression  = "(m1/m2)*100"
    label       = "Disk Space Used"
    return_data = "true"
  }

  metric_query {
    id = "m1"

    metric {
      metric_name = "disk_used"
      namespace   = "${var.name}/smtp"
      period      = 60
      stat        = "Average"

      dimensions = {
        host   = substr("mail${count.index + 1}.${data.aws_route53_zone.public.name}", 0, 64)
        path   = "/"
        fstype = "xfs"
        device = "xvda1"
      }
    }
  }

  metric_query {
    id = "m2"

    metric {
      metric_name = "disk_total"
      namespace   = "${var.name}/smtp"
      period      = 60
      stat        = "Average"

      dimensions = {
        host   = substr("mail${count.index + 1}.${data.aws_route53_zone.public.name}", 0, 64)
        path   = "/"
        fstype = "xfs"
        device = "xvda1"
      }
    }
  }

  tags = var.tags
}

resource "aws_cloudwatch_metric_alarm" "instance_system_errors" {
  count = length(module.postfix_vpc.private_subnets)

  alarm_name          = "postfix${count.index + 1}-system-status-check-failed"
  alarm_description   = "${aws_instance.postfix[count.index].tags["Name"]} is failing system status checks"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 5
  period              = 60
  statistic           = "Average"
  threshold           = 1
  metric_name         = "StatusCheckFailed_System"
  namespace           = "AWS/EC2"
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
  }

  tags = var.tags
}

resource "aws_cloudwatch_metric_alarm" "instance_errors" {
  count = length(module.postfix_vpc.private_subnets)

  alarm_name          = "postfix${count.index + 1}-instance-status-check-failed"
  alarm_description   = "${aws_instance.postfix[count.index].tags["Name"]} is failing instance status checks"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 5
  period              = 60
  statistic           = "Average"
  threshold           = 1
  metric_name         = "StatusCheckFailed_Instance"
  namespace           = "AWS/EC2"
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
  }

  tags = var.tags
}

resource "aws_cloudwatch_metric_alarm" "healthy_instances" {
  count = length(module.postfix_vpc.private_subnets)

  alarm_name          = "postfix-nlb-healthy-instances"
  alarm_description   = "${aws_lb_target_group.postfix_smtps.name} is reporting less than required instances"
  comparison_operator = "LessThanThreshold"
  evaluation_periods  = 5
  period              = 60
  statistic           = "Average"
  threshold           = 2
  metric_name         = "HealthyHostCount"
  namespace           = "AWS/NetworkELB"
  treat_missing_data  = "ignore"

  alarm_actions = [
    var.cloudwatch_notifications_arn
  ]
  ok_actions = [
    var.cloudwatch_notifications_arn
  ]
  actions_enabled = true

  dimensions = {
    TargetGroup  = aws_lb_target_group.postfix_smtps.arn_suffix
    LoadBalancer = aws_lb.postfix_nlb.arn_suffix
  }

  tags = var.tags
}
