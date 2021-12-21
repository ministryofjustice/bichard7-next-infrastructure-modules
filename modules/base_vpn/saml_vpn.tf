resource "aws_ec2_client_vpn_endpoint" "saml_client_vpn_endpoint" {
  count = (local.deploy_saml == true) ? 1 : 0

  description            = "${var.name_prefix}-saml-clientvpn-endpoint"
  server_certificate_arn = aws_acm_certificate.server_cert.arn
  client_cidr_block      = var.client_cidr_block
  split_tunnel           = true

  dns_servers = aws_route53_resolver_endpoint.dns_endpoint.ip_address.*.ip

  authentication_options {
    type              = "federated-authentication"
    saml_provider_arn = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:saml-provider/Azure-AD"
  }

  connection_log_options {
    enabled               = true
    cloudwatch_log_group  = var.vpn_log_group.name
    cloudwatch_log_stream = aws_cloudwatch_log_stream.vpn.name
  }

  tags = var.tags
}

resource "aws_ec2_client_vpn_network_association" "saml_private_network_association_a" {
  count = (local.deploy_saml == true) ? 1 : 0

  subnet_id = element(local.allowed_subnet_ids, 0)

  client_vpn_endpoint_id = aws_ec2_client_vpn_endpoint.saml_client_vpn_endpoint[count.index].id

  lifecycle {
    ignore_changes = [subnet_id]
  }
}

resource "aws_ec2_client_vpn_network_association" "saml_private_network_association_b" {
  count = (local.deploy_saml == true) ? 1 : 0

  subnet_id = element(local.allowed_subnet_ids, 1)

  client_vpn_endpoint_id = aws_ec2_client_vpn_endpoint.saml_client_vpn_endpoint[count.index].id

  lifecycle {
    ignore_changes = [subnet_id]
  }
}

resource "aws_ec2_client_vpn_network_association" "saml_private_network_association_c" {
  count = (local.deploy_saml == true) ? 1 : 0

  subnet_id = element(local.allowed_subnet_ids, 2)

  client_vpn_endpoint_id = aws_ec2_client_vpn_endpoint.saml_client_vpn_endpoint[count.index].id

  lifecycle {
    ignore_changes = [subnet_id]
  }
}

resource "null_resource" "authorize_saml_client_vpn_ingress" {
  count = (local.deploy_saml == true) ? 1 : 0

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
          --client-vpn-endpoint-id ${aws_ec2_client_vpn_endpoint.saml_client_vpn_endpoint[count.index].id} \
          --target-network-cidr 0.0.0.0/0 \
          --authorize-all-groups
      EOF

  }

  depends_on = [
    aws_ec2_client_vpn_endpoint.saml_client_vpn_endpoint,
    aws_ec2_client_vpn_network_association.saml_private_network_association_a,
    aws_ec2_client_vpn_network_association.saml_private_network_association_b,
    aws_ec2_client_vpn_network_association.saml_private_network_association_c
  ]
}
