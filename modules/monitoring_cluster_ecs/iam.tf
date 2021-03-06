## Prometheus ECS Task
resource "aws_iam_role" "prometheus_task_role" {
  name               = "${var.name}-Prometheus-Task"
  assume_role_policy = file("${path.module}/policies/ecs_task_role.json")

  tags = var.tags
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

## Prometheus Cloudwatch SSM
resource "aws_iam_policy" "prometheus_cloudwatch_ssm" {
  policy = data.template_file.allow_ssm.rendered

  name = "PrometheusAllowSSM-${var.name}"
  tags = var.tags
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
  policy = data.template_file.allow_sns_events_publish.rendered
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
  policy = data.template_file.allow_notifications_kms_access.rendered
  role   = aws_iam_role.prometheus_task_role.id
}

# tfsec:ignore:aws-iam-no-policy-wildcards
resource "aws_iam_policy" "allow_ecs_task_secretsmanager" {
  name = "allow_ecs_task_secretsmanager"

  policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Effect" : "Allow",
        "Action" : [
          "secretsmanager:*",
          "kms:*"
        ],
        "Resource" : [data.aws_secretsmanager_secret.os_password.arn, data.aws_kms_key.secret_encryption_key.arn]
      },
      {
        "Effect" : "Allow",
        "Action" : [
          "secretsmanager:GetRandomPassword"
        ],
        "Resource" : "*"
      }

    ]
  })

  tags = var.tags
}

resource "aws_iam_role_policy_attachment" "prometheus_allow_secrets_manager" {
  role       = aws_iam_role.prometheus_task_role.id
  policy_arn = aws_iam_policy.allow_ecs_task_secretsmanager.arn
}
