data "template_file" "allow_assume_administrator_access" {
  template = file("${path.module}/policies/allow_assume_admin_access.json.tpl")

  vars = {
    admin_access_arn = var.admin_access_arn
  }
}

data "template_file" "allow_assume_ci_access" {
  template = file("${path.module}/policies/allow_assume_ci_access.json.tpl")

  vars = {
    ci_access_arn = var.ci_access_arn
  }
}

data "template_file" "allow_assume_readonly_access" {
  template = file("${path.module}/policies/allow_assume_readonly_access.json.tpl")

  vars = {
    readonly_access_arn = var.readonly_access_arn
  }
}
