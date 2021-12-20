locals {
  access_template = (length(var.denied_user_arns) > 0) ? "allow_assume_role_with_deny.json.tpl" : "allow_assume_role.json.tpl"
}
