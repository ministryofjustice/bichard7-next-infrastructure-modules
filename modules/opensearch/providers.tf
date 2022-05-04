provider "elasticsearch" {
  url      = "https://${aws_elasticsearch_domain.os.endpoint}"
  username = local.os_user_name
  #password              = jsondecode(aws_secretsmanager_secret_version.os_password.secret_string)
  password    = aws_ssm_parameter.es_password.value
  sniff       = false
  aws_region  = data.aws_region.current.name
  healthcheck = false
  # elasticsearch_version = aws_elasticsearch_domain.os.elasticsearch_version
  elasticsearch_version = "OpenSearch_1.0"
  sign_aws_requests     = false
}
