provider "elasticsearch" {
  url                   = "https://${aws_elasticsearch_domain.os.endpoint}"
  username              = local.os_user_name
  password              = aws_secretsmanager_secret_version.os_password.secret_string
  sniff                 = false
  aws_region            = data.aws_region.current.name
  healthcheck           = false
  elasticsearch_version = aws_elasticsearch_domain.os.elasticsearch_version
  sign_aws_requests     = false
}
