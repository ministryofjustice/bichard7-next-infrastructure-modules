locals {
  cidr_block      = ((var.vpc_cidr_block == null) ? "20.0.0.0/16" : var.vpc_cidr_block)
  cidr_sub_blocks = cidrsubnets(local.cidr_block, 8, 8, 8, 8, 8, 8)
  env             = replace(terraform.workspace, "_", "")

  ### CSJM remote IP address
  cjsm_mail_server_address = "51.140.32.204/32"
  cjsm_mail_server_dns     = "mail.cjsm.net"

  postfix_fqdn = "mail.${data.aws_route53_zone.public.name}"

  log_retention = (lookup(var.tags, "is-production", false) == false) ? 90 : 731

  # Cluster config
  cluster_name  = "${var.name}-postfix"
  postfix_tasks = 3
  cpu_units     = 1024
  memory_units  = 4096

  # Cloudwatch alarm values
  cpu_threshold            = 75
  mem_threshold            = 75
  evaluation_threshold     = 5
  evaluation_seconds       = 60
  ecs_evaluation_threshold = 5
  ecs_evaluation_seconds   = 60
  min_postfix_tasks        = 1
}
