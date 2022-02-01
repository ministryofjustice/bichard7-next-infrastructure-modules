# Lambda logging bucket

Creates a bucket to use with Lambda Cloudtrails

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.13 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | = 3.72.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 3.72.0 |
| <a name="provider_template"></a> [template](#provider\_template) | 2.2.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_cloudtrail.lambda_trail](https://registry.terraform.io/providers/hashicorp/aws/3.72.0/docs/resources/cloudtrail) | resource |
| [aws_kms_alias.lambda_trail_encryption](https://registry.terraform.io/providers/hashicorp/aws/3.72.0/docs/resources/kms_alias) | resource |
| [aws_kms_key.lambda_trail_encryption](https://registry.terraform.io/providers/hashicorp/aws/3.72.0/docs/resources/kms_key) | resource |
| [aws_s3_bucket.lambda_logs_bucket](https://registry.terraform.io/providers/hashicorp/aws/3.72.0/docs/resources/s3_bucket) | resource |
| [aws_s3_bucket_public_access_block.lambda_logs_bucket](https://registry.terraform.io/providers/hashicorp/aws/3.72.0/docs/resources/s3_bucket_public_access_block) | resource |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/3.72.0/docs/data-sources/caller_identity) | data source |
| [template_file.lambda_cloudtrail_policy](https://registry.terraform.io/providers/hashicorp/template/latest/docs/data-sources/file) | data source |
| [template_file.lambda_logging_bucket](https://registry.terraform.io/providers/hashicorp/template/latest/docs/data-sources/file) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_logging_bucket"></a> [logging\_bucket](#input\_logging\_bucket) | The name of the logging bucket we want to log our s3 information to | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | The name of the resource, used as a prefix | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of resource tags | `map(string)` | `{}` | no |

## Outputs

No outputs.
<!-- END_TF_DOCS -->
