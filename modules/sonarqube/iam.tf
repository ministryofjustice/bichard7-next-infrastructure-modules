resource "aws_iam_role" "sonarqube_task_role" {
  name               = "${var.name}-Sonar-Task"
  assume_role_policy = file("${path.module}/policies/sonarqube_task_role.json")

  tags = var.tags
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

  tags = var.tags
}

resource "aws_iam_role_policy_attachment" "sonarqube_allow_ecr_attachment" {
  policy_arn = aws_iam_policy.sonarqube_allow_ecr_access.arn
  role       = aws_iam_role.sonarqube_task_role.name
}

resource "aws_iam_role_policy" "allow_ssm" {
  policy = data.template_file.allow_ssm.rendered
  role   = aws_iam_role.sonarqube_task_role.id
}

resource "aws_kms_key" "cloudwatch_encryption" {
  description = "${var.name}-cloudwatch-encryption"

  enable_key_rotation     = true
  deletion_window_in_days = 7

  policy = data.template_file.cloudwatch_encryption.rendered

  tags = var.tags
}

resource "aws_kms_alias" "cloudwatch_kms_alias" {
  target_key_id = aws_kms_key.cloudwatch_encryption.arn
  name          = "alias/${aws_kms_key.cloudwatch_encryption.description}"
}
