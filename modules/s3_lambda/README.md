# S3 Lambda

Deploys lambda functions from a s3 bucket

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
| <a name="provider_aws.parent"></a> [aws.parent](#provider\_aws.parent) | 3.72.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_lambda_function.lambda](https://registry.terraform.io/providers/hashicorp/aws/3.72.0/docs/resources/lambda_function) | resource |
| [aws_s3_bucket_object.file](https://registry.terraform.io/providers/hashicorp/aws/3.72.0/docs/data-sources/s3_bucket_object) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_bucket_name"></a> [bucket\_name](#input\_bucket\_name) | The name of the bucket | `string` | n/a | yes |
| <a name="input_environment_variables"></a> [environment\_variables](#input\_environment\_variables) | A map of environment variables | `map(string)` | `null` | no |
| <a name="input_filename"></a> [filename](#input\_filename) | The filename of the lambda artifact in S3 | `string` | n/a | yes |
| <a name="input_function_name"></a> [function\_name](#input\_function\_name) | The name of our lambda function | `string` | n/a | yes |
| <a name="input_iam_role_arn"></a> [iam\_role\_arn](#input\_iam\_role\_arn) | The ARN of our lambda execution role | `string` | n/a | yes |
| <a name="input_lambda_directory"></a> [lambda\_directory](#input\_lambda\_directory) | The directory where our artifacts are stored in S3 | `string` | n/a | yes |
| <a name="input_lambda_runtime"></a> [lambda\_runtime](#input\_lambda\_runtime) | The runtime we want use for the lambda | `string` | `"nodejs14.x"` | no |
| <a name="input_memory_size"></a> [memory\_size](#input\_memory\_size) | The memory size of the lambda | `number` | `128` | no |
| <a name="input_override_function_name"></a> [override\_function\_name](#input\_override\_function\_name) | Do we want to override the generated function name | `bool` | `false` | no |
| <a name="input_reserved_concurrent_executions"></a> [reserved\_concurrent\_executions](#input\_reserved\_concurrent\_executions) | Amount of reserved concurrent executions for this lambda function | `number` | `-1` | no |
| <a name="input_resource_prefix"></a> [resource\_prefix](#input\_resource\_prefix) | A prefix for our function name for multi environment deployments | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of tags for this object | `map(string)` | `{}` | no |
| <a name="input_timeout"></a> [timeout](#input\_timeout) | Execution timeout in seconds for this lambda function | `number` | `30` | no |
| <a name="input_vpc_config"></a> [vpc\_config](#input\_vpc\_config) | The configuration values to connect the Lambda to a VPC | <pre>object({<br>    subnet_ids         = set(string)<br>    security_group_ids = set(string)<br>  })</pre> | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_function_name"></a> [function\_name](#output\_function\_name) | The name of the Lambda Function |
| <a name="output_function_name_without_prefix"></a> [function\_name\_without\_prefix](#output\_function\_name\_without\_prefix) | The name of the Lambda Function without the prefix |
| <a name="output_lambda_arn"></a> [lambda\_arn](#output\_lambda\_arn) | The ARN of the Lambda Function |
<!-- END_TF_DOCS -->
