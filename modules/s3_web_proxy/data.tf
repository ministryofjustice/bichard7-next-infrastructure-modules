data "aws_caller_identity" "current" {}

data "aws_region" "current" {}

data "template_file" "s3_web_proxy_fargate" {
  template = file("${path.module}/templates/s3_web_proxy.tpl")

  vars = {
    container_name        = var.name
    s3_web_proxy_image    = local.s3_web_proxy_image
    scanning_cpu_units    = local.scanning_cpu_units
    scanning_memory_units = local.scanning_memory_units
    bucket_name           = var.bucket_name
    access_key_arn        = aws_ssm_parameter.s3_web_proxy_access_key.arn
    secret_key_arn        = aws_ssm_parameter.s3_web_proxy_secret_key.arn
    config_cpu_units      = local.config_cpu_units
    config_memory_units   = local.config_memory_units

    log_group         = aws_cloudwatch_log_group.ecs_log_group.name
    log_stream_prefix = var.name
    region            = data.aws_region.current.name
  }
}

data "aws_route53_zone" "public" {
  zone_id = var.public_zone_id
}

data "template_file" "allow_cloudwatch_kms" {
  template = file("${path.module}/policies/cloudwatch_kms_policy.json.tpl")

  vars = {
    account_id            = data.aws_caller_identity.current.account_id
    s3_web_proxy_user_arn = aws_iam_user.s3_web_proxy_user.arn
    region                = data.aws_region.current.name
  }
}

data "template_file" "web_proxy_user_policy" {
  template = file("${path.module}/policies/web_proxy_user_policy.json.tpl")

  vars = {
    bucket_name = var.bucket_name
  }
}
