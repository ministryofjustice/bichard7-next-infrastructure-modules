resource "aws_iam_policy" "allow_assume_aws_nuke_access_role" {
  count  = (var.aws_nuke_access_arn != null) ? 1 : 0
  name   = "Assume-AWS-Nume-Access-on-${var.child_account_id}"
  policy = data.template_file.allow_assume_aws_nuke_access[count.index].rendered
}

resource "aws_iam_group_policy_attachment" "aws_nuke_access_policy_attachment" {
  count      = (var.aws_nuke_access_arn != null) ? 1 : 0
  policy_arn = aws_iam_policy.allow_assume_aws_nuke_access_role[count.index].arn
  group      = var.ci_access_group_name
}
