resource "aws_flow_log" "vpc_flow_log" {
  log_destination = var.vpc_flow_log_group.arn
  iam_role_arn    = aws_iam_role.flow_log_role.arn
  vpc_id          = var.vpc_id
  traffic_type    = "ALL"
}

resource "aws_iam_role" "flow_log_role" {
  name               = "vpc-flow-logs-role-${var.vpc_name}"
  assume_role_policy = file("${path.module}/policies/flow_log_assume_role.json")
}

# tfsec:ignore:aws-iam-no-policy-wildcards
resource "aws_iam_role_policy" "flow_log_role_policy" {
  name   = "vpc-flow-logs-role-policy-${var.vpc_name}"
  role   = aws_iam_role.flow_log_role.id
  policy = file("${path.module}/policies/flow_log_policy.json") # tfsec:ignore:aws-iam-no-policy-wildcards
}

resource "aws_cloudwatch_log_metric_filter" "flow_log_metric_filter_denied" {
  name           = "cloudtrail-alarms-VpcFlowLogMetricFilter"
  log_group_name = var.vpc_flow_log_group.name
  pattern        = "{$.errorCode = \"AccessDenied\"}"

  metric_transformation {
    name      = "VpcFlowLog1AccessDenied"
    namespace = "LogMetrics"
    value     = "1"
  }
}

resource "aws_cloudwatch_log_metric_filter" "flow_log_metric_filter_reject" {
  name           = "cloudtrail-alarms-VpcFlowRejectFilter"
  log_group_name = var.vpc_flow_log_group.name
  pattern        = "REJECT"

  metric_transformation {
    name      = "VpcFlowLogRejectCount"
    namespace = "LogMetrics"
    value     = "1"
  }
}

resource "aws_cloudwatch_metric_alarm" "flow_log_reject_alarm" {
  alarm_name          = "VpcFlowLogRejectAlarm"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  metric_name         = "VpcFlowLogRejectCount"
  statistic           = "Sum"
  period              = 300
  threshold           = 1
  evaluation_periods  = 1
  datapoints_to_alarm = 1
  namespace           = var.vpc_name

  tags = var.tags
}

resource "aws_cloudwatch_metric_alarm" "flow_log_denied_alarm" {
  alarm_name          = "VpcFlowLog1Alarm"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  metric_name         = "VpcFlowLog1AccessDenied"
  statistic           = "Sum"
  period              = 300
  threshold           = 1
  evaluation_periods  = 1
  datapoints_to_alarm = 1
  namespace           = var.vpc_name

  tags = var.tags
}
