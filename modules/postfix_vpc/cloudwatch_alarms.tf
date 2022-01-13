resource "aws_cloudwatch_metric_alarm" "postfix_cluster_cpu_usage" {
  alarm_name          = "Postfix CPU Usage for ${terraform.workspace}"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = local.evaluation_threshold
  metric_name         = "CPUUtilization"
  namespace           = "AWS/ECS"
  period              = local.evaluation_seconds
  statistic           = "Average"
  threshold           = local.cpu_threshold
  alarm_description   = "Postfix CPU usage above ${local.cpu_threshold}% for ${terraform.workspace} environment"
  treat_missing_data  = "ignore"
  alarm_actions = [
    var.cloudwatch_notifications_arn
  ]
  ok_actions = [
    var.cloudwatch_notifications_arn
  ]
  actions_enabled = true

  dimensions = {
    ServiceName = module.postfix_ecs_cluster.ecs_service.name
    ClusterName = local.cluster_name
  }

  tags = var.tags
}

resource "aws_cloudwatch_metric_alarm" "postfix_cluster_memory_usage" {
  alarm_name          = "Postfix Memory Usage for ${terraform.workspace}"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = local.evaluation_threshold
  metric_name         = "MemoryUtilization"
  namespace           = "AWS/ECS"
  period              = local.evaluation_seconds
  statistic           = "Average"
  threshold           = local.mem_threshold
  alarm_description   = "Postfix Memory usage above ${local.mem_threshold}% for ${terraform.workspace} environment"
  treat_missing_data  = "ignore"
  alarm_actions = [
    var.cloudwatch_notifications_arn
  ]
  ok_actions = [
    var.cloudwatch_notifications_arn
  ]
  actions_enabled = true

  dimensions = {
    ServiceName = module.postfix_ecs_cluster.ecs_service.name
    ClusterName = local.cluster_name
  }

  tags = var.tags
}


resource "aws_cloudwatch_metric_alarm" "postfix_service_running_tasks" {
  alarm_name          = "Postfix running tasks under threshold for ${terraform.workspace}"
  comparison_operator = "LessThanThreshold"
  evaluation_periods  = local.ecs_evaluation_threshold
  metric_name         = "RunningTaskCount"
  namespace           = "ECS/ContainerInsights"
  period              = local.ecs_evaluation_seconds
  statistic           = "Average"
  threshold           = local.min_postfix_tasks
  alarm_description   = "Postfix tasks under threshold of ${local.min_postfix_tasks} for ${module.postfix_ecs_cluster.ecs_service.name} in ${terraform.workspace} environment"
  treat_missing_data  = "ignore"
  alarm_actions = [
    var.cloudwatch_notifications_arn
  ]
  ok_actions = [
    var.cloudwatch_notifications_arn
  ]
  actions_enabled = true

  dimensions = {
    ServiceName = module.postfix_ecs_cluster.ecs_service.name
    ClusterName = local.cluster_name
  }

  tags = var.tags
}

resource "aws_cloudwatch_metric_alarm" "postfix_service_running_containers" {
  alarm_name = "Postfix running containers under threshold for ${terraform.workspace}"

  evaluation_periods  = local.ecs_evaluation_threshold
  period              = local.ecs_evaluation_seconds
  threshold           = local.min_postfix_tasks
  treat_missing_data  = "ignore"
  namespace           = "AWS/NetworkELB"
  metric_name         = "HealthyHostCount"
  statistic           = "Average"
  comparison_operator = "LessThanThreshold"
  alarm_description   = "Postfix healthy containers under threshold of ${local.min_postfix_tasks} on loadbalancer ${module.postfix_nlb.load_balancer.name} in ${terraform.workspace} environment"

  dimensions = {
    TargetGroup  = module.postfix_nlb.target_group.name
    LoadBalancer = module.postfix_nlb.load_balancer
  }

  alarm_actions = [
    var.cloudwatch_notifications_arn
  ]
  ok_actions = [
    var.cloudwatch_notifications_arn
  ]
  actions_enabled = true

  tags = var.tags
}
