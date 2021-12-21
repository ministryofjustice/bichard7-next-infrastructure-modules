data "aws_region" "current" {}

data "aws_caller_identity" "current" {}

data "aws_security_group" "es" {
  name = "${var.name}-elasticsearch"
}

data "aws_cloudwatch_log_group" "es_log_group" {
  name = var.elasticsearch_log_groups.elasticsearch
}

data "template_file" "elasticsearch_access_policy" {
  template = file("${path.module}/policies/es_access_policy.json.tpl")

  vars = {
    account_id  = data.aws_caller_identity.current.account_id
    cidr_blocks = jsonencode(var.admin_allowed_cidr)
    es_domain   = "arn:aws:es:${local.region_name}:${local.account_id}:domain/${local.domain_name}/*"
  }
}

data "template_file" "opensearch_ism_prune_policy" {
  template = file("${path.module}/files/prune_index_policy.json")

  vars = {
    deletion_window = local.deletion_window
  }
}
