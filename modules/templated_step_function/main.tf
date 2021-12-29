resource "aws_sfn_state_machine" "step_function" {
  name       = var.name
  role_arn   = var.iam_role_arn
  definition = data.template_file.state_machine_definition.rendered

  logging_configuration {
    log_destination        = var.cloud_watch_logs_group_arn
    include_execution_data = true
    level                  = "ERROR"
  }

  tags = var.tags
}
