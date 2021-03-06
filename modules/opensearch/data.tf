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
      ]
    )
  }
}

data "archive_file" "secrets_rotation_lambda" {
  output_path = "/tmp/secrets_rotation.zip"
  type        = "zip"

  source {
    content = templatefile("${path.module}/functions/secrets_rotation.py.tpl", {
      os_username              = "bichard",
      opensearch_custom_domain = aws_elasticsearch_domain.es.domain_endpoint_options.*.custom_endpoint[0]
      logstash_cluster         = "cjse-${terraform.workspace}-bichard-7-monitoring"
      logstash_service         = "cjse-${terraform.workspace}-bichard-7-logstash"
    })
    filename = "secrets_rotation.py"
  }
}

data "aws_iam_policy" "write_to_cloudwatch" {
  name = "bichard-7-${lower(var.tags["Environment"])}-lambda-write-cloudwatch-logs"
}

data "aws_iam_policy" "lambda_decrypt_env_vars" {
  name = "bichard-7-${lower(var.tags["Environment"])}-lambda-decrypt-env-vars-policy"
}

data "aws_iam_policy" "manage_ec2_network_interfaces" {
  name = "bichard-7-${lower(var.tags["Environment"])}-lambda-manage-ec2-network-interfaces"
}

data "aws_security_group" "secretsmanager_vpce" {
  name = "cjse-${lower(var.tags["Environment"])}-bichard-7-secretsmanager-vpce"
}

data "aws_security_group" "lambda_egress_to_secretsmanager_vpce" {
  name = "cjse-${lower(var.tags["Environment"])}-bichard-7-secrets-rotation-to-secrets-vpce"
}

data "aws_security_group" "resource_to_vpc" {
  name = "cjse-${lower(var.tags["Environment"])}-bichard-7-resource-to-vpc"
}

data "aws_secretsmanager_secret_version" "os_password" {
  secret_id = aws_secretsmanager_secret.os_password.id

  depends_on = [
    aws_secretsmanager_secret.os_password,
    aws_secretsmanager_secret_version.os_password
  ]
}
