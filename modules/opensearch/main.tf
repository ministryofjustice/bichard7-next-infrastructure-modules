resource "random_password" "os" {
  length      = 24
  special     = true
  min_special = 1
  upper       = true
  min_upper   = 1
  number      = true
  min_numeric = 1
  lower       = true
  min_lower   = 1
}

resource "aws_ssm_parameter" "es_password" {
  name      = "/${var.name}/es/master/password"
  type      = "SecureString"
  value     = random_password.os.result
  overwrite = true

  tags = var.tags
}

resource "aws_kms_key" "secret_encryption_key" {
  description             = "${var.name} secret key"
  deletion_window_in_days = 10
  enable_key_rotation     = true

  tags = var.tags
}

resource "aws_kms_alias" "secret" {
  target_key_id = aws_kms_key.secret_encryption_key.id
  name          = "alias/${var.name}-os-secret"
}

resource "aws_secretsmanager_secret" "os_password" {
  name       = "${var.name}-opensearch-password"
  kms_key_id = aws_kms_key.secret_encryption_key.id

  tags = var.tags
}

resource "aws_secretsmanager_secret_version" "os_password" {
  secret_id     = aws_secretsmanager_secret.os_password.id
  secret_string = random_password.os.result
}

data "aws_secretsmanager_secret_version" "os_password" {
  secret_id = aws_secretsmanager_secret.os_password.id

  depends_on = [
    aws_secretsmanager_secret.os_password,
    aws_secretsmanager_secret_version.os_password
  ]
}

resource "aws_ssm_parameter" "os_user" {
  name      = "/${var.name}/os/master/username"
  type      = "SecureString"
  value     = local.os_user_name
  overwrite = true

  tags = var.tags
}

resource "aws_elasticsearch_domain" "os" {
  domain_name           = local.domain_name
  elasticsearch_version = "OpenSearch_1.0"

  access_policies = data.template_file.elasticsearch_access_policy.rendered

  advanced_security_options {
    enabled                        = true
    internal_user_database_enabled = true

    master_user_options {
      master_user_name = local.os_user_name
      #master_user_password = data.aws_secretsmanager_secret_version.os_password.secret_string
      master_user_password = aws_ssm_parameter.es_password.value
    }
  }

  cluster_config {
    instance_count         = 3
    instance_type          = var.instance_type
    zone_awareness_enabled = true

    zone_awareness_config {
      availability_zone_count = 3
    }
  }

  vpc_options {
    security_group_ids = [data.aws_security_group.es.id]
    subnet_ids         = var.service_subnets
  }

  ebs_options {
    ebs_enabled = true
    volume_size = var.ebs_volume_size
  }

  snapshot_options {
    automated_snapshot_start_hour = 23
  }

  encrypt_at_rest {
    enabled = true
  }

  node_to_node_encryption {
    enabled = true
  }

  domain_endpoint_options {
    enforce_https       = true
    tls_security_policy = "Policy-Min-TLS-1-2-2019-07"

    custom_endpoint_enabled         = true
    custom_endpoint                 = "elasticsearch.${var.public_zone_name}"
    custom_endpoint_certificate_arn = var.server_certificate_arn
  }

  tags = merge(
    local.es_tags,
    { Domain = local.name }
  )

  log_publishing_options {
    cloudwatch_log_group_arn = var.elasticsearch_log_group.arn
    log_type                 = "INDEX_SLOW_LOGS"
    enabled                  = true
  }

  log_publishing_options {
    cloudwatch_log_group_arn = var.elasticsearch_log_group.arn
    log_type                 = "SEARCH_SLOW_LOGS"
    enabled                  = true
  }

  log_publishing_options {
    cloudwatch_log_group_arn = var.elasticsearch_log_group.arn
    log_type                 = "ES_APPLICATION_LOGS"
    enabled                  = true
  }

  log_publishing_options {
    cloudwatch_log_group_arn = var.elasticsearch_log_group.arn
    log_type                 = "AUDIT_LOGS"
    enabled                  = true
  }

  depends_on = [time_sleep.wait_for_log_group]
}

resource "time_sleep" "wait_for_log_group" {
  depends_on = [data.aws_cloudwatch_log_group.es_log_group]

  create_duration = "30s"
}

resource "aws_cloudwatch_log_resource_policy" "elasticsearch_logs_policy" {
  policy_name     = "${local.name}_elasticsearch_logs_policy"
  policy_document = file("${path.module}/policies/es_log_policy.json")
}

resource "aws_route53_record" "elasticsearch" {
  name    = "elasticsearch.${var.public_zone_name}"
  type    = "CNAME"
  zone_id = var.public_zone_id
  ttl     = 60

  records = [
    aws_elasticsearch_domain.os.endpoint
  ]
}

resource "elasticsearch_opendistro_role" "writer" {
  count = local.deploy_opendistro_roles

  role_name   = "logs_writer"
  description = "Logs writer role"

  cluster_permissions = ["*"]

  index_permissions {
    index_patterns  = ["*"]
    allowed_actions = ["*"]
  }

  depends_on = [
    aws_elasticsearch_domain.os,
    elasticsearch_kibana_object.cloudwatch_index_pattern
  ]
}

resource "elasticsearch_kibana_object" "cloudwatch_index_pattern" {
  count = local.deploy_opendistro_roles

  body = file("${path.module}/files/cloudwatch_index_pattern.json")
}

resource "elasticsearch_opendistro_ism_policy" "prune_indices_after_n_days" {
  count     = local.deploy_opendistro_roles
  policy_id = "delete-after-${local.deletion_window}"
  body      = data.template_file.opensearch_ism_prune_policy.rendered
}

resource "elasticsearch_opendistro_role" "backup" {
  count = local.deploy_opendistro_roles

  role_name   = "s3_archive_writer"
  description = "Read and archive our indices to s3"

  cluster_permissions = ["*"]

  index_permissions {
    index_patterns  = ["*"]
    allowed_actions = ["*"]
  }

  depends_on = [
    aws_elasticsearch_domain.os,
    elasticsearch_kibana_object.cloudwatch_index_pattern
  ]
}

resource "elasticsearch_opendistro_roles_mapping" "s3_archiver" {
  count = local.deploy_opendistro_roles

  role_name = elasticsearch_opendistro_role.backup[count.index].role_name

  description = "Allow user to archive data to s3"
  backend_roles = [
    aws_iam_role.snapshot_create.arn,
    aws_iam_role.snapshot_lambda.arn,
    "arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/Bichard7-Administrator-Access",
    "arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/Bichard7-CI-Access"
  ]

  depends_on = [
    aws_elasticsearch_domain.os
  ]
}
