data "aws_region" "current" {}

data "template_file" "openvpn" {
  template = file("${path.module}/templates/open_vpn_config.tpl")

  vars = {
    endpoint_url   = local.endpoint_url
    ca_cert        = file("${var.cert_dir}/ca.crt")
    user_cert_path = "./client1.${var.domain}.crt"
    user_key_path  = "./client1.${var.domain}.key"
    subnet_routes  = local.subnet_routes
  }
}

data "aws_caller_identity" "current" {}
