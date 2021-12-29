output "step_function_arn" {
  description = "The ARN of the Step Function"
  value       = aws_sfn_state_machine.step_function.arn
}

output "state_machine_definition" {
  description = "The rendered output of the state machine definition file"
  value       = data.template_file.state_machine_definition.rendered
}
