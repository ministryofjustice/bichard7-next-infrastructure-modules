resource "aws_iam_instance_profile" "bastion_instance_profile" {
  name = "${var.name}-bastion-instance-profile"
  role = aws_iam_role.bastion_role.name

  tags = var.tags
}

resource "aws_iam_role" "bastion_role" {
  name               = "${var.name}-bastion-role"
  assume_role_policy = file("${path.module}/policies/bastion_role_policy.json")

  tags = var.tags
}

resource "aws_iam_role_policy" "allow_bastion_ssm_access" {
  policy = data.template_file.bastion_allow_ssm_parameters.rendered
  role   = aws_iam_role.bastion_role.id
}

resource "aws_iam_instance_profile" "postfix_instance_profile" {
  name = "${var.name}-postfix-instance-profile"
  role = aws_iam_role.postfix_role.name

  tags = var.tags
}

resource "aws_iam_role" "postfix_role" {
  name               = "${var.name}-postfix-role"
  assume_role_policy = file("${path.module}/policies/bastion_role_policy.json")

  tags = var.tags
}

resource "aws_iam_role_policy" "postfix_allow_ssm" {
  policy = data.template_file.postfix_allow_ssm_parameters.rendered
  role   = aws_iam_role.postfix_role.id
}

resource "aws_iam_role_policy_attachment" "postfix_cloudwatch_agent" {
  policy_arn = "arn:aws:iam::aws:policy/CloudWatchAgentServerPolicy"
  role       = aws_iam_role.postfix_role.name
}

# tfsec:ignore:aws-iam-no-policy-wildcards
resource "aws_iam_role_policy" "postfix_cloudwatch_logs" {
  name   = "allow-postfix-cloudwatch-logs"
  policy = file("${path.module}/policies/allow_cloudwatch_logs.json")
  role   = aws_iam_role.postfix_role.id
}
