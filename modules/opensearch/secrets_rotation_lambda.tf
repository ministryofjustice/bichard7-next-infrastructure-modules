resource "aws_secretsmanager_secret_rotation" "os_password" {
  secret_id           = aws_secretsmanager_secret.os_password.id
  rotation_lambda_arn = aws_lambda_function.secrets_rotation_lambda.arn

  rotation_rules {
    automatically_after_days = 7
  }
}
#
# tfsec:ignore:aws-iam-no-policy-wildcards
resource "aws_iam_policy" "allow_lambda_secretsmanager" {
  name = "allow_lambda_secretsmanager"

  policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Effect" : "Allow",
        "Action" : [
          "secretsmanager:*",
          "kms:*"
        ],
        "Resource" : [aws_secretsmanager_secret.os_password.arn, aws_kms_key.secret_encryption_key.arn]
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

resource "aws_iam_role" "iam_for_secrets_rotation_lambda" {
  name = "iam_for_lambda"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF

  managed_policy_arns = [
    data.aws_iam_policy.lambda_decrypt_env_vars.arn,
    data.aws_iam_policy.write_to_cloudwatch.arn,
    data.aws_iam_policy.manage_ec2_network_interfaces.arn,
    aws_iam_policy.allow_lambda_secretsmanager.arn
  ]

  depends_on = [
    aws_iam_policy.allow_lambda_secretsmanager
  ]
}

resource "aws_lambda_function" "secrets_rotation_lambda" {
  filename         = data.archive_file.secrets_rotation_lambda.output_path
  source_code_hash = data.archive_file.secrets_rotation_lambda.output_base64sha256
  function_name    = "secrets_rotation_lambda"
  role             = aws_iam_role.iam_for_secrets_rotation_lambda.arn
  handler          = "secrets_rotation.lambda_handler"

  memory_size = "128"
  runtime     = "python3.8"
  timeout     = 60

  vpc_config {
    subnet_ids = var.service_subnets
    security_group_ids = [
      data.aws_security_group.lambda_egress_to_secretsmanager_vpce.id,
      data.aws_security_group.resource_to_vpc.id
    ]
  }

  tags = var.tags
}

resource "aws_lambda_permission" "secrets_rotation_lambda" {
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.secrets_rotation_lambda.function_name
  principal     = "secretsmanager.amazonaws.com"
  source_arn    = aws_secretsmanager_secret.os_password.arn
}