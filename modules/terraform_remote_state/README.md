# Terraform Remote State

Creates a dynamodb table and s3 bucket to handle terraform remote state

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.13 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | = 3.56.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 3.56.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_dynamodb_table.terraform_state_lock](https://registry.terraform.io/providers/hashicorp/aws/3.56.0/docs/resources/dynamodb_table) | resource |
| [aws_kms_alias.remote_state_key_alias](https://registry.terraform.io/providers/hashicorp/aws/3.56.0/docs/resources/kms_alias) | resource |
| [aws_kms_key.terraform_remote_state_key](https://registry.terraform.io/providers/hashicorp/aws/3.56.0/docs/resources/kms_key) | resource |
| [aws_s3_bucket.terraform_remote_state](https://registry.terraform.io/providers/hashicorp/aws/3.56.0/docs/resources/s3_bucket) | resource |
| [aws_s3_bucket_public_access_block.terraform_remote_state](https://registry.terraform.io/providers/hashicorp/aws/3.56.0/docs/resources/s3_bucket_public_access_block) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_bucket-object-name"></a> [bucket-object-name](#input\_bucket-object-name) | The path to our statefile | `string` | `"/infra/tfstatefile"` | no |
| <a name="input_logging_bucket_name"></a> [logging\_bucket\_name](#input\_logging\_bucket\_name) | The bucket we send our access logs to | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | The bucket name prefix | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of infrastructure tags for our resources | `map(string)` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_aws_dynamodb_table"></a> [aws\_dynamodb\_table](#output\_aws\_dynamodb\_table) | The name of our remote state bucket |
| <a name="output_aws_s3_bucket"></a> [aws\_s3\_bucket](#output\_aws\_s3\_bucket) | The name of our remote state bucket |
| <a name="output_bucket_object_name"></a> [bucket\_object\_name](#output\_bucket\_object\_name) | The name of our remote state bucket object |
<!-- END_TF_DOCS -->
