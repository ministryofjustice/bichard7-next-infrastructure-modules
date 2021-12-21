resource "aws_acm_certificate" "client_cert" {
  private_key       = local.user_private_key
  certificate_body  = local.user_certificate_body
  certificate_chain = local.certificate_chain
  tags              = var.tags
}

resource "aws_ssm_parameter" "vpn_user_private_key" {
  name      = "/${var.name_prefix}/vpn/user_private_key"
  type      = "SecureString"
  value     = local.user_private_key
  overwrite = true
  tags      = var.tags
}

resource "aws_ssm_parameter" "vpn_user_crt" {
  name      = "/${var.name_prefix}/vpn/user_certificate_body"
  type      = "SecureString"
  value     = local.user_certificate_body
  overwrite = true
  tags      = var.tags
  tier      = "Advanced"
}

resource "aws_ssm_parameter" "vpn_crt" {
  name      = "/${var.name_prefix}/vpn/certificate_chain"
  type      = "SecureString"
  value     = local.certificate_chain
  overwrite = true
  tags      = var.tags
}


resource "aws_acm_certificate" "server_cert" {
  private_key       = file("${var.cert_dir}/server.key")
  certificate_chain = file("${var.cert_dir}/ca.crt")
  certificate_body  = file("${var.cert_dir}/server.crt")
  tags              = var.tags
}


resource "aws_cloudwatch_log_stream" "vpn" {
  name           = "${var.name_prefix}-vpn-connection-log"
  log_group_name = var.vpn_log_group.name
}

resource "aws_ec2_client_vpn_endpoint" "client_vpn_endpoint" {
  description            = "terraform-clientvpn-endpoint"
  server_certificate_arn = aws_acm_certificate.server_cert.arn
  client_cidr_block      = var.client_cidr_block
  split_tunnel           = true

  dns_servers = aws_route53_resolver_endpoint.dns_endpoint.ip_address.*.ip

  authentication_options {
    type                       = "certificate-authentication"
    root_certificate_chain_arn = aws_acm_certificate.client_cert.arn
  }

  connection_log_options {
    enabled               = true
    cloudwatch_log_group  = var.vpn_log_group.name
    cloudwatch_log_stream = aws_cloudwatch_log_stream.vpn.name
  }

  tags = var.tags
}

resource "aws_ec2_client_vpn_network_association" "private_network_association_a" {
  subnet_id = element(local.allowed_subnet_ids, 0)

  client_vpn_endpoint_id = aws_ec2_client_vpn_endpoint.client_vpn_endpoint.id

  lifecycle {
    ignore_changes = [subnet_id]
  }
}

resource "aws_ec2_client_vpn_network_association" "private_network_association_b" {
  subnet_id = element(local.allowed_subnet_ids, 1)

  client_vpn_endpoint_id = aws_ec2_client_vpn_endpoint.client_vpn_endpoint.id

  lifecycle {
    ignore_changes = [subnet_id]
  }
}

resource "aws_ec2_client_vpn_network_association" "private_network_association_c" {
  subnet_id = element(local.allowed_subnet_ids, 2)

  client_vpn_endpoint_id = aws_ec2_client_vpn_endpoint.client_vpn_endpoint.id

  lifecycle {
    ignore_changes = [subnet_id]
  }
}

# local-exec has no visibility of the assume role statement so we have to do an assume role and then
# has the session pass these variables through
# see https://github.com/hashicorp/terraform-provider-aws/issues/8242#issuecomment-586687360
resource "null_resource" "authorize-client-vpn-ingress-shared" {

  provisioner "local-exec" {
    interpreter = ["/bin/bash", "-c"]
    command     = <<-EOF
      set -e
      CREDENTIALS=(`aws sts assume-role \
        --role-arn ${var.aws_role} \
        --role-session-name "db-migration-cli" \
        --query "[Credentials.AccessKeyId,Credentials.SecretAccessKey,Credentials.SessionToken]" \
        --output text`)

      unset AWS_PROFILE
      unset AWS_SECURITY_TOKEN
      export AWS_DEFAULT_REGION=us-east-1
      export AWS_ACCESS_KEY_ID="$${CREDENTIALS[0]}"
      export AWS_SECRET_ACCESS_KEY="$${CREDENTIALS[1]}"
      export AWS_SESSION_TOKEN="$${CREDENTIALS[2]}"

      aws --region ${data.aws_region.current.id} ec2 authorize-client-vpn-ingress \
          --client-vpn-endpoint-id ${aws_ec2_client_vpn_endpoint.client_vpn_endpoint.id} \
          --target-network-cidr 0.0.0.0/0 \
          --authorize-all-groups
      EOF

  }

  triggers = {
    aws_acm_client_certificate_changed = base64encode(aws_acm_certificate.client_cert.certificate_body)
    aws_acm_server_certificate_changed = base64encode(aws_acm_certificate.server_cert.certificate_body)
  }

  depends_on = [
    aws_ec2_client_vpn_endpoint.client_vpn_endpoint,
    aws_ec2_client_vpn_network_association.private_network_association_a,
    aws_ec2_client_vpn_network_association.private_network_association_b,
    aws_ec2_client_vpn_network_association.private_network_association_c
  ]
}

resource "random_string" "random" {
  length = 10
  lower  = true

  number  = false
  special = false
  upper   = false
}

resource "aws_ssm_parameter" "vpn_config" {
  name        = "/${var.name_prefix}/vpn/config"
  type        = "SecureString"
  value       = data.template_file.openvpn.rendered
  overwrite   = true
  description = "open vpn config for vpn"
  tags        = var.tags
}

resource "local_file" "config" {
  filename = "${pathexpand(var.cert_dir)}/${var.name_prefix}-vpn-config.ovpn"

  content = data.template_file.openvpn.rendered
}


resource "aws_route53_resolver_endpoint" "dns_endpoint" {
  name      = "${var.name_prefix}-dns-endpoint"
  direction = "INBOUND"

  security_group_ids = [
    aws_security_group.dns_endpoint.id
  ]

  dynamic "ip_address" {
    for_each = var.allowed_subnet_ids
    content {
      subnet_id = ip_address.value
    }
  }

  tags = var.tags
}
