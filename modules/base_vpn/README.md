# Base VPN

Module that configures an AWS OpenVPN compatible vpn using certificate based authentication as well as an
options saml based vpn

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.13 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | = 3.72.0 |
| <a name="requirement_local"></a> [local](#requirement\_local) | = 2.0.0 |
| <a name="requirement_null"></a> [null](#requirement\_null) | = 3.0.0 |
| <a name="requirement_random"></a> [random](#requirement\_random) | = 3.0.1 |
| <a name="requirement_template"></a> [template](#requirement\_template) | = 2.2.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | = 3.72.0 |
| <a name="provider_local"></a> [local](#provider\_local) | = 2.0.0 |
| <a name="provider_null"></a> [null](#provider\_null) | = 3.0.0 |
| <a name="provider_random"></a> [random](#provider\_random) | = 3.0.1 |
| <a name="provider_template"></a> [template](#provider\_template) | = 2.2.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_acm_certificate.client_cert](https://registry.terraform.io/providers/hashicorp/aws/3.72.0/docs/resources/acm_certificate) | resource |
| [aws_acm_certificate.server_cert](https://registry.terraform.io/providers/hashicorp/aws/3.72.0/docs/resources/acm_certificate) | resource |
| [aws_cloudwatch_log_stream.vpn](https://registry.terraform.io/providers/hashicorp/aws/3.72.0/docs/resources/cloudwatch_log_stream) | resource |
| [aws_ec2_client_vpn_endpoint.client_vpn_endpoint](https://registry.terraform.io/providers/hashicorp/aws/3.72.0/docs/resources/ec2_client_vpn_endpoint) | resource |
| [aws_ec2_client_vpn_endpoint.saml_client_vpn_endpoint](https://registry.terraform.io/providers/hashicorp/aws/3.72.0/docs/resources/ec2_client_vpn_endpoint) | resource |
| [aws_ec2_client_vpn_network_association.private_network_association_a](https://registry.terraform.io/providers/hashicorp/aws/3.72.0/docs/resources/ec2_client_vpn_network_association) | resource |
| [aws_ec2_client_vpn_network_association.private_network_association_b](https://registry.terraform.io/providers/hashicorp/aws/3.72.0/docs/resources/ec2_client_vpn_network_association) | resource |
| [aws_ec2_client_vpn_network_association.private_network_association_c](https://registry.terraform.io/providers/hashicorp/aws/3.72.0/docs/resources/ec2_client_vpn_network_association) | resource |
| [aws_ec2_client_vpn_network_association.saml_private_network_association_a](https://registry.terraform.io/providers/hashicorp/aws/3.72.0/docs/resources/ec2_client_vpn_network_association) | resource |
| [aws_ec2_client_vpn_network_association.saml_private_network_association_b](https://registry.terraform.io/providers/hashicorp/aws/3.72.0/docs/resources/ec2_client_vpn_network_association) | resource |
| [aws_ec2_client_vpn_network_association.saml_private_network_association_c](https://registry.terraform.io/providers/hashicorp/aws/3.72.0/docs/resources/ec2_client_vpn_network_association) | resource |
| [aws_route53_resolver_endpoint.dns_endpoint](https://registry.terraform.io/providers/hashicorp/aws/3.72.0/docs/resources/route53_resolver_endpoint) | resource |
| [aws_security_group.dns_endpoint](https://registry.terraform.io/providers/hashicorp/aws/3.72.0/docs/resources/security_group) | resource |
| [aws_security_group_rule.dns_endpoint_tcp_ingress](https://registry.terraform.io/providers/hashicorp/aws/3.72.0/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.dns_endpoint_udp_ingress](https://registry.terraform.io/providers/hashicorp/aws/3.72.0/docs/resources/security_group_rule) | resource |
| [aws_ssm_parameter.vpn_config](https://registry.terraform.io/providers/hashicorp/aws/3.72.0/docs/resources/ssm_parameter) | resource |
| [aws_ssm_parameter.vpn_crt](https://registry.terraform.io/providers/hashicorp/aws/3.72.0/docs/resources/ssm_parameter) | resource |
| [aws_ssm_parameter.vpn_user_crt](https://registry.terraform.io/providers/hashicorp/aws/3.72.0/docs/resources/ssm_parameter) | resource |
| [aws_ssm_parameter.vpn_user_private_key](https://registry.terraform.io/providers/hashicorp/aws/3.72.0/docs/resources/ssm_parameter) | resource |
| [local_file.config](https://registry.terraform.io/providers/hashicorp/local/2.0.0/docs/resources/file) | resource |
| [null_resource.authorize-client-vpn-ingress-shared](https://registry.terraform.io/providers/hashicorp/null/3.0.0/docs/resources/resource) | resource |
| [null_resource.authorize_saml_client_vpn_ingress](https://registry.terraform.io/providers/hashicorp/null/3.0.0/docs/resources/resource) | resource |
| [random_string.random](https://registry.terraform.io/providers/hashicorp/random/3.0.1/docs/resources/string) | resource |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/3.72.0/docs/data-sources/caller_identity) | data source |
| [aws_region.current](https://registry.terraform.io/providers/hashicorp/aws/3.72.0/docs/data-sources/region) | data source |
| [template_file.openvpn](https://registry.terraform.io/providers/hashicorp/template/2.2.0/docs/data-sources/file) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_allowed_subnet_cidr_blocks"></a> [allowed\_subnet\_cidr\_blocks](#input\_allowed\_subnet\_cidr\_blocks) | the vpn will have access to these subnets | `list(string)` | n/a | yes |
| <a name="input_allowed_subnet_ids"></a> [allowed\_subnet\_ids](#input\_allowed\_subnet\_ids) | the vpn will have access to these subnets | `list(string)` | n/a | yes |
| <a name="input_aws_role"></a> [aws\_role](#input\_aws\_role) | The name of the role we want to use for our sts assume call | `string` | `""` | no |
| <a name="input_cert_dir"></a> [cert\_dir](#input\_cert\_dir) | The directory in which our vpn certificates live | `string` | n/a | yes |
| <a name="input_client_cidr_block"></a> [client\_cidr\_block](#input\_client\_cidr\_block) | The allowed cidr blocks | `string` | n/a | yes |
| <a name="input_domain"></a> [domain](#input\_domain) | The domain name used for the certificate | `string` | n/a | yes |
| <a name="input_name_prefix"></a> [name\_prefix](#input\_name\_prefix) | A prefix used for naming | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of environmental tags | `map(string)` | n/a | yes |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | The vpc id | `string` | n/a | yes |
| <a name="input_vpn_log_group"></a> [vpn\_log\_group](#input\_vpn\_log\_group) | The cloudwatch log group for our VPN | `any` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_dns_endpoint_security_group_id"></a> [dns\_endpoint\_security\_group\_id](#output\_dns\_endpoint\_security\_group\_id) | The ID of the dns\_endpoint security group |
| <a name="output_endpoint_url"></a> [endpoint\_url](#output\_endpoint\_url) | The aws vpn endpoint url |
<!-- END_TF_DOCS -->
