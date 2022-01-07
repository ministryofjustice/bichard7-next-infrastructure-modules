resource "aws_iam_user" "nuke_user" {
  count = (var.create_nuke_user == true) ? 1 : 0
  name  = data.aws_ssm_parameter.aws_nuke_user[count.index].value
  path  = "/system/"

  tags = var.tags
}

resource "aws_iam_user_group_membership" "nuke_user" {
  count = (var.create_nuke_user == true) ? 1 : 0

  groups = [
    aws_iam_group.aws_nuke_group[count.index].name
  ]
  user = aws_iam_user.nuke_user[count.index].name
}

## Allow our nuke user to assume our nuke on this account so it can get temporary credentials
resource "aws_iam_role" "assume_nuke_access_on_parent" {
  count = (var.create_nuke_user == true) ? 1 : 0

  name                 = "Bichard7-Aws-Nuke-Access"
  max_session_duration = 10800
  assume_role_policy   = data.template_file.allow_assume_administrator_access_template.rendered

  tags = var.tags
}
