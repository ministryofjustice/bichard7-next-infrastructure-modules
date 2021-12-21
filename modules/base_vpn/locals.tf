locals {
  user_private_key      = file("${var.cert_dir}/client1.${var.domain}.key")
  user_certificate_body = file("${var.cert_dir}/client1.${var.domain}.crt")
  certificate_chain     = file("${var.cert_dir}/ca.crt")

  endpoint_url = replace(aws_ec2_client_vpn_endpoint.client_vpn_endpoint.dns_name, "*", random_string.random.result)

  subnet_routes = <<-EOT
  %{for cidr_block in var.allowed_subnet_cidr_blocks}
  route ${cidrhost(cidr_block, 0)} ${cidrnetmask(cidr_block)}
  %{endfor}
  EOT

  allowed_subnet_ids = sort(var.allowed_subnet_ids)

  deploy_saml = (terraform.workspace == "preprod")
}
