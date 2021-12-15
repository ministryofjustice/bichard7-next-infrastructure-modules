# Self signed certificate

Module to create self signed ssl certificates

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.13 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | = 3.56.0 |
| <a name="requirement_tls"></a> [tls](#requirement\_tls) | = 3.1.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 3.56.0 |
| <a name="provider_tls"></a> [tls](#provider\_tls) | 3.1.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_iam_server_certificate.self_signed_certificate](https://registry.terraform.io/providers/hashicorp/aws/3.56.0/docs/resources/iam_server_certificate) | resource |
| [aws_ssm_parameter.rsa_private_key](https://registry.terraform.io/providers/hashicorp/aws/3.56.0/docs/resources/ssm_parameter) | resource |
| [aws_ssm_parameter.self_signed_certificate](https://registry.terraform.io/providers/hashicorp/aws/3.56.0/docs/resources/ssm_parameter) | resource |
| [aws_ssm_parameter.ssl_signing_certificate](https://registry.terraform.io/providers/hashicorp/aws/3.56.0/docs/resources/ssm_parameter) | resource |
| [tls_cert_request.ssl_signing_certificate](https://registry.terraform.io/providers/hashicorp/tls/3.1.0/docs/resources/cert_request) | resource |
| [tls_private_key.rsa_private_key](https://registry.terraform.io/providers/hashicorp/tls/3.1.0/docs/resources/private_key) | resource |
| [tls_self_signed_cert.self_signed_certificate](https://registry.terraform.io/providers/hashicorp/tls/3.1.0/docs/resources/self_signed_cert) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_tags"></a> [tags](#input\_tags) | The tags to use for resources | `map(string)` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_server_certificate"></a> [server\_certificate](#output\_server\_certificate) | The ssl certificate we have created for this deployment |
<!-- END_TF_DOCS -->
