resource "tls_private_key" "public_domain_signing_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_ssm_parameter" "public_domain_signing_key" {
  name  = "/${var.name}/smtp/private_key"
  type  = "SecureString"
  value = tls_private_key.public_domain_signing_key.private_key_pem

  tags = var.tags
}

resource "tls_cert_request" "public_domain_signing_certificate" {
  key_algorithm   = "RSA"
  private_key_pem = tls_private_key.public_domain_signing_key.private_key_pem
  subject {
    common_name         = data.aws_route53_zone.public.name
    organization        = "CJSE"
    organizational_unit = "Bichard7"
  }

  dns_names = [
    aws_route53_record.mail.fqdn
  ]
}

resource "aws_ssm_parameter" "public_domain_smtp_csr" {
  name  = "/${var.name}/smtp/csr"
  type  = "SecureString"
  value = tls_cert_request.public_domain_signing_certificate.cert_request_pem

  tags = var.tags
}

module "smtp_nginx_self_signed_certificate" {
  source = "github.com/ministryofjustice/bichard7-next-infrastructure-modules.git//modules/self_signed_certificate?ref=upgrade-aws-provider"

  tags = merge(
    var.tags,
    {
      Name = "${var.tags["Name"]}-smtp"
    }
  )
}
