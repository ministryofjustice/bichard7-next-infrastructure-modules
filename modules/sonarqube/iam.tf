resource "aws_iam_role" "sonarqube_task_role" {
  name               = "${var.name}-Sonar-Task"
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
  role       = aws_iam_role.sonarqube_task_role.name
  policy_arn = "arn:aws:iam::aws:policy/AWSCodeDeployRoleForECS"
}

resource "aws_iam_role_policy_attachment" "attach_ecs_task_execution" {
  role       = aws_iam_role.sonarqube_task_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}

resource "aws_iam_policy" "sonarqube_allow_ecr_access" {
  policy = data.template_file.allow_ecr_policy.rendered
  name   = "SonarqubeAllowECR-${var.name}"
}

resource "aws_iam_role_policy_attachment" "sonarqube_allow_ecr_attachment" {
  policy_arn = aws_iam_policy.sonarqube_allow_ecr_access.arn
  role       = aws_iam_role.sonarqube_task_role.name
}

resource "aws_iam_role_policy" "allow_ssm" {
  policy = <<-EOF
  {
    "Version": "2012-10-17",
    "Statement": [
      {
        "Sid": "",
        "Effect": "Allow",
        "Action": [
          "ssm:PutParameter",
          "ssm:GetParameter",
          "ssm:GetParameters"
        ],
        "Resource": [
          "${aws_ssm_parameter.sonar_db_password.arn}",
          "${aws_ssm_parameter.sonar_db_user.arn}"
        ]
      }
    ]
  }
  EOF
  role   = aws_iam_role.sonarqube_task_role.id
}

resource "aws_kms_key" "cloudwatch_encryption" {
  description = "${var.name}-cloudwatch-encryption"

  enable_key_rotation     = true
  deletion_window_in_days = 7

  policy = <<-EOF
  {
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "Enable IAM User Permissions",
      "Effect": "Allow",
      "Principal": {
        "AWS": [
          "arn:aws:iam::${data.aws_caller_identity.current.account_id}:root",
          "arn:aws:iam::${data.aws_caller_identity.current.account_id}:user/system/cjse.ci"
        ]
      },
      "Action": "kms:*",
      "Resource": "*"
    },
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "logs.${data.aws_region.current.name}.amazonaws.com"
      },
      "Action": [
        "kms:Encrypt*",
        "kms:Decrypt*",
        "kms:ReEncrypt*",
        "kms:GenerateDataKey*",
        "kms:Describe*"
      ],
      "Resource": "*",
      "Condition": {
        "ArnEquals": {
          "kms:EncryptionContext:aws:logs:arn": "arn:aws:logs:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:*"
        }
      }
    }
  ]
}
  EOF

  tags = var.tags
}

resource "aws_kms_alias" "cloudwatch_kms_alias" {
  target_key_id = aws_kms_key.cloudwatch_encryption.arn
  name          = "alias/${aws_kms_key.cloudwatch_encryption.description}"
}
