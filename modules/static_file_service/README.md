# Static file service

Module to deploy a s3 web server container to allow files to be downloaded/browsed from a private
s3 bucket over https

<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 3.75.2 |
| <a name="provider_template"></a> [template](#provider\_template) | 2.2.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_static_file_service"></a> [static\_file\_service](#module\_static\_file\_service) | github.com/ministryofjustice/bichard7-next-infrastructure-modules.git//modules/s3_web_proxy | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_s3_bucket.static_file_bucket](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket) | resource |
| [aws_s3_bucket_policy.static_file_bucket](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_policy) | resource |
| [aws_s3_bucket_public_access_block.static_file_bucket](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_public_access_block) | resource |
| [template_file.static_file_bucket](https://registry.terraform.io/providers/hashicorp/template/latest/docs/data-sources/file) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_logging_bucket_name"></a> [logging\_bucket\_name](#input\_logging\_bucket\_name) | The default logging bucket for lb access logs | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | Name to be used on all the resources as identifier | `string` | n/a | yes |
| <a name="input_parent_account_id"></a> [parent\_account\_id](#input\_parent\_account\_id) | The id of the parent account | `string` | n/a | yes |
| <a name="input_public_zone_id"></a> [public\_zone\_id](#input\_public\_zone\_id) | The zone id for our public hosted zone so we can use ACM certificates | `string` | n/a | yes |
| <a name="input_s3_web_proxy_arn"></a> [s3\_web\_proxy\_arn](#input\_s3\_web\_proxy\_arn) | The arn for the web proxy ecr repository | `string` | n/a | yes |
| <a name="input_s3_web_proxy_image"></a> [s3\_web\_proxy\_image](#input\_s3\_web\_proxy\_image) | The web proxy image to deploy | `string` | n/a | yes |
| <a name="input_service_subnets"></a> [service\_subnets](#input\_service\_subnets) | The subnets on which our alb will serve traffic | `list(string)` | n/a | yes |
| <a name="input_ssl_certificate_arn"></a> [ssl\_certificate\_arn](#input\_ssl\_certificate\_arn) | The arn of our ssl certificate | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | The tags for the resources | `map(string)` | n/a | yes |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | The ID of the VPC that the RDS cluster will be created in | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_alb_dns"></a> [alb\_dns](#output\_alb\_dns) | DNS entry for load balancer |
| <a name="output_bucket_name"></a> [bucket\_name](#output\_bucket\_name) | The name of the static file service s3 bucket |
| <a name="output_fqdn"></a> [fqdn](#output\_fqdn) | The public fqdn for the alb |
<!-- END_TF_DOCS -->
