plugin "aws" {
    enabled = true
    version = "0.8.0"
    source  = "github.com/terraform-linters/tflint-ruleset-aws"
}

rule "aws_lb_target_group_invalid_target_type" {
  enabled = false
}
