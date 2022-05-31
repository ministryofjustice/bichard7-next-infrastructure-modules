provider "elasticsearch" {
  url                   = "https://${aws_elasticsearch_domain.es.endpoint}"
  username              = local.es_user_name
  password              = nonsensitive(data.aws_secretsmanager_secret_version.os_password.secret_string)
  sniff                 = false
  aws_region            = data.aws_region.current.name
  healthcheck           = false
  elasticsearch_version = aws_elasticsearch_domain.es.elasticsearch_version
  sign_aws_requests     = false
}
