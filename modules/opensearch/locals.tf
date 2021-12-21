locals {
  account_id       = data.aws_caller_identity.current.account_id
  name             = "es-${var.name}"
  region_name      = data.aws_region.current.name
  sg_name          = "es-${var.name}-sg"
  domain_name      = var.name
  log_group_name   = var.name
  lambda_role_name = "${var.name}-cw-l-role"
  es_tags = merge(var.tags, {
    "Name" = local.name
  })

  es_user_name = "bichard"

  deploy_opendistro_roles = (terraform.workspace == "e2e-test" || terraform.workspace == "preprod" || terraform.workspace == "production") ? 1 : 0
  deletion_window         = (terraform.workspace != "production") ? "21d" : "90d"
}
