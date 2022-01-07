resource "aws_iam_role" "assume_aws_nuke_access" {
  count                = (var.create_nuke_user == true) ? 1 : 0
  name                 = "Bichard7-Aws-Nuke-Access"
  max_session_duration = 10800
  assume_role_policy   = data.template_file.allow_assume_aws_nuke_access[count.index].rendered

  tags = var.tags
}

resource "aws_iam_role_policy_attachment" "assume_nuke_access_admin_access" {
  count      = (var.create_nuke_user == true) ? 1 : 0
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
  role       = aws_iam_role.assume_aws_nuke_access[count.index].name
}
