resource "aws_acm_certificate" "base_infra_certificate" {
  domain_name = trim(data.terraform_remote_state.account_resources.outputs.delegated_hosted_zone.name, ".")
  subject_alternative_names = [
    "*.${trim(data.terraform_remote_state.account_resources.outputs.delegated_hosted_zone.name, ".")}"
  ]

  validation_method = "DNS"

  tags = var.tags

  lifecycle {
    create_before_destroy = true
  }
}

locals {
  child_record  = tolist(aws_acm_certificate.base_infra_certificate.domain_validation_options)[0]
  parent_record = tolist(aws_acm_certificate.base_infra_certificate.domain_validation_options)[1]
}

resource "aws_route53_record" "base_infra_public_zone_validation_records" {
  allow_overwrite = true
  name            = local.child_record.resource_record_name
  records         = [local.child_record.resource_record_value]
  ttl             = 60
  type            = local.child_record.resource_record_type
  zone_id         = data.terraform_remote_state.account_resources.outputs.delegated_hosted_zone.zone_id
}

resource "aws_route53_record" "parent_zone_validation_records" {
  allow_overwrite = true
  name            = local.parent_record.resource_record_name
  records         = [local.parent_record.resource_record_value]
  ttl             = 60
  type            = local.parent_record.resource_record_type
  zone_id         = data.terraform_remote_state.account_resources.outputs.delegated_hosted_zone.zone_id
}

resource "aws_acm_certificate_validation" "base_infra_certificate_validation" {
  certificate_arn = aws_acm_certificate.base_infra_certificate.arn
}

resource "aws_route53_record" "sonar_record" {
  name    = "sonar.${data.terraform_remote_state.account_resources.outputs.delegated_hosted_zone.name}"
  type    = "CNAME"
  zone_id = data.terraform_remote_state.account_resources.outputs.delegated_hosted_zone.zone_id
  records = [aws_alb.sonar_alb.dns_name]
  ttl     = 60
}

resource "aws_route53_record" "db_entry" {
  name    = "db.${data.terraform_remote_state.account_resources.outputs.delegated_hosted_zone.name}"
  type    = "CNAME"
  zone_id = data.terraform_remote_state.account_resources.outputs.delegated_hosted_zone.zone_id
  records = [aws_db_instance.sonar_db.address]
  ttl     = 60
}
