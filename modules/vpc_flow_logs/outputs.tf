output "flow_log_denied_alarm_arn" {
  description = "The ARN of our vpc flow log access denied alarm"
  value       = aws_cloudwatch_metric_alarm.flow_log_denied_alarm.arn
}

output "flow_log_reject_alarm_arn" {
  description = "The ARN of our vpc flow log access reject alarm"
  value       = aws_cloudwatch_metric_alarm.flow_log_reject_alarm.arn
}
