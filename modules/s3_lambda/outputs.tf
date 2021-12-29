output "lambda_arn" {
  description = "The ARN of the Lambda Function"
  value       = aws_lambda_function.lambda.arn
}

output "function_name" {
  description = "The name of the Lambda Function"
  value       = aws_lambda_function.lambda.function_name
}
