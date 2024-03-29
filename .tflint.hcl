plugin "aws" {
    enabled = true
    version = "0.18.0"
    source  = "github.com/terraform-linters/tflint-ruleset-aws"
}

rule "aws_lb_target_group_invalid_target_type" {
  enabled = false
}

rule "aws_lambda_function_deprecated_runtime" {
  enabled = false
}
