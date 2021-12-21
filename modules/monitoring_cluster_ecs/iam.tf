resource "aws_iam_role" "prometheus_task_role" {
  name               = "${var.name}-Prometheus-Task"
  assume_role_policy = <<-EOF
    {
      "Version": "2008-10-17",
      "Statement": [
        {
          "Effect": "Allow",
          "Principal": {
            "Service": "ecs-tasks.amazonaws.com"
          },
          "Action": "sts:AssumeRole"
        }
      ]
    }
  EOF
}

resource "aws_iam_role_policy_attachment" "attach_ecs_code_deploy_role_for_ecs" {
  role       = aws_iam_role.prometheus_task_role.name
  policy_arn = "arn:aws:iam::aws:policy/AWSCodeDeployRoleForECS"
}

resource "aws_iam_role_policy_attachment" "attach_ecs_task_execution" {
  role       = aws_iam_role.prometheus_task_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}

resource "aws_iam_role_policy_attachment" "attach_cloudwatch_readonly" {
  role       = aws_iam_role.prometheus_task_role.name
  policy_arn = "arn:aws:iam::aws:policy/CloudWatchReadOnlyAccess"
}

resource "aws_iam_policy" "prometheus_cloudwatch_ssm" {
  policy = data.template_file.allow_ssm.rendered
  name   = "PrometheusAllowSSM-${var.name}"
}

resource "aws_iam_role_policy_attachment" "prometheus_cloudwatch_ssm_attachment" {
  policy_arn = aws_iam_policy.prometheus_cloudwatch_ssm.arn
  role       = aws_iam_role.prometheus_task_role.name
}

resource "aws_iam_policy" "prometheus_allow_ecr_access" {
  policy = data.template_file.allow_ecr_policy.rendered
  name   = "PrometheusAllowECR-${var.name}"
}

resource "aws_iam_role_policy_attachment" "prometheus_allow_ecr_attachment" {
  policy_arn = aws_iam_policy.prometheus_allow_ecr_access.arn
  role       = aws_iam_role.prometheus_task_role.name
}

resource "aws_iam_policy" "prometheus_allow_sns_publish" {
  name   = "PrometheusAllowSNSPublish-${var.name}"
  policy = <<-EOF
  {
    "Version": "2012-10-17",
    "Statement": [
      {
        "Sid": "AllowAwsEventsPublish",
        "Effect": "Allow",
        "Action": "SNS:Publish",
        "Resource": "${aws_sns_topic.alert_notifications.arn}"
      }
    ]
  }
  EOF
}

resource "aws_iam_role_policy_attachment" "prometheus_allow_sns_publish" {
  role       = aws_iam_role.prometheus_task_role.id
  policy_arn = aws_iam_policy.prometheus_allow_sns_publish.arn
}

resource "aws_iam_role_policy" "allow_ssm_messages" {
  count = (var.remote_exec_enabled == true) ? 1 : 0

  name   = "${var.name}-ssm-messages"
  policy = data.template_file.allow_ssm_messages.rendered
  role   = aws_iam_role.prometheus_task_role.id
}

resource "aws_iam_role_policy" "allow_prometheus_notifications_kms_access" {
  policy = <<-EOF
  {
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "kms:DescribeKey",
                "kms:GenerateDataKey",
                "kms:Encrypt",
                "kms:Decrypt",
                "kms:*Grant"
            ],
            "Resource": "${aws_kms_key.alert_notifications_key.arn}"
        },
        {
            "Effect": "Allow",
            "Action": [
                "kms:List*"
            ],
            "Resource": "*"
        }
    ]
  }
  EOF
  role   = aws_iam_role.prometheus_task_role.id
}
