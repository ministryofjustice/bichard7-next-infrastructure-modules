locals {
  cidr_block      = ((var.vpc_cidr_block == null) ? "20.0.0.0/16" : var.vpc_cidr_block)
  cidr_sub_blocks = cidrsubnets(local.cidr_block, 8, 8, 8, 8, 8, 8)
  env             = replace(terraform.workspace, "_", "")

  # We need to convert the object into a list of route table ids
  //  remote_rtb_ids = [for rtb in data.aws_route_table.infra_to_postfix_subnet_route_table : rtb.id]

  ### CSJM remote IP address
  cjsm_mail_server_address = "51.140.32.204/32"
  cjsm_mail_server_dns     = "mail.cjsm.net"

  postfix_fqdn = "mail.${data.aws_route53_zone.public.name}"

  log_retention = (lookup(var.tags, "is-production", false) == false) ? 90 : 731
}
