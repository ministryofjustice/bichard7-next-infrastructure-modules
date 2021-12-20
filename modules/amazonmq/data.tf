data "aws_caller_identity" "current" {}

data "aws_route53_zone" "cjse_dot_org" {
  zone_id = var.private_zone_id
}

data "aws_iam_policy_document" "amazon_mq_log_publishing_policy" {
  statement {
    actions = [
      "logs:CreateLogStream",
      "logs:PutLogEvents",
    ]

    resources = ["arn:aws:logs:*"]

    principals {
      identifiers = ["mq.amazonaws.com"]
      type        = "Service"
    }
  }
}

data "aws_security_group" "amq" {
  name = "${var.environment_name}-amq"
}

data "aws_security_group" "bichard7_web" {
  name = "${var.environment_name}-web"
}

data "aws_security_group" "bichard7_backend" {
  name = "${var.environment_name}-backend"
}
