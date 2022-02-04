data "aws_region" "current" {}

data "aws_caller_identity" "current" {}

data "aws_security_group" "es" {
  name = "${var.name}-elasticsearch"
}

data "aws_security_group" "snapshot_lambda" {
  name = "${var.name}-opensearch-snapshot-lambda"
}

data "aws_cloudwatch_log_group" "es_log_group" {
  name = var.elasticsearch_log_groups.elasticsearch
}

data "aws_cloudwatch_log_group" "opensearch_snapshot_lambda" {
  name = "/aws/lambda/cjse-bichard7-${lower(var.tags["Environment"])}-base-infra-opensearch-snapshot-lambda"
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

data "template_file" "snapshot_s3_policy" {
  template = file("${path.module}/policies/snapshot_bucket_access_role_policy.json.tpl")

  vars = {
    bucket_arn = aws_s3_bucket.snapshot.arn
  }
}

data "template_file" "snapshot_s3_lambda_policy" {
  template = file("${path.module}/policies/lambda_role_policy.json.tpl")

  vars = {
    es_role_arn              = aws_iam_role.snapshot_create.arn
    es_domain_arn            = aws_elasticsearch_domain.es.arn
    cloudwatch_log_group_arn = data.aws_cloudwatch_log_group.opensearch_snapshot_lambda.arn
    ssm_params = jsonencode(
      [
        aws_ssm_parameter.es_user.arn,
        aws_ssm_parameter.es_password.arn
      ]
    )
  }
}

data "archive_file" "snapshot_lambda" {
  type        = "zip"
  output_path = "${path.module}/snapshot_lambda.zip"
  source_dir  = "${path.module}/functions/"

  depends_on = [
    null_resource.install_lambda_deps
  ]
}
