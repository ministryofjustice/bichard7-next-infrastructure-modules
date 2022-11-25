# S3 Lambda

Deploys lambda functions from a s3 bucket

<!-- BEGIN_TF_DOCS -->

## Requirements

| Name                                                                     | Version  |
| ------------------------------------------------------------------------ | -------- |
| <a name="requirement_terraform"></a> [terraform](#requirement_terraform) | >= 0.13  |
| <a name="requirement_aws"></a> [aws](#requirement_aws)                   | = 3.75.2 |

## Providers

| Name                                                                  | Version |
| --------------------------------------------------------------------- | ------- |
| <a name="provider_aws"></a> [aws](#provider_aws)                      | 3.75.2  |
| <a name="provider_aws.parent"></a> [aws.parent](#provider_aws.parent) | 3.75.2  |

## Modules

No modules.

## Resources

| Name                                                                                                                         | Type        |
| ---------------------------------------------------------------------------------------------------------------------------- | ----------- |
| [aws_lambda_function.lambda](https://registry.terraform.io/providers/hashicorp/aws/3.75.2/docs/resources/lambda_function)    | resource    |
| [aws_s3_bucket_object.file](https://registry.terraform.io/providers/hashicorp/aws/3.75.2/docs/data-sources/s3_bucket_object) | data source |

## Inputs

| Name                                                                                                                        | Description                                                                  | Type                                                                                         | Default        | Required |
| --------------------------------------------------------------------------------------------------------------------------- | ---------------------------------------------------------------------------- | -------------------------------------------------------------------------------------------- | -------------- | :------: |
| <a name="input_bucket_name"></a> [bucket_name](#input_bucket_name)                                                          | The name of the bucket                                                       | `string`                                                                                     | n/a            |   yes    |
| <a name="input_environment_variables"></a> [environment_variables](#input_environment_variables)                            | A map of environment variables                                               | `map(string)`                                                                                | `null`         |    no    |
| <a name="input_filename"></a> [filename](#input_filename)                                                                   | The filename of the lambda artifact in S3                                    | `string`                                                                                     | n/a            |   yes    |
| <a name="input_function_description"></a> [function_description](#input_function_description)                               | The optional friendly description of the function                            | `string`                                                                                     | `""`           |    no    |
| <a name="input_function_name"></a> [function_name](#input_function_name)                                                    | The name of our lambda function                                              | `string`                                                                                     | n/a            |   yes    |
| <a name="input_handler_name"></a> [handler_name](#input_handler_name)                                                       | The name of the functions event handler, if null it will be filename.default | `string`                                                                                     | `null`         |    no    |
| <a name="input_iam_role_arn"></a> [iam_role_arn](#input_iam_role_arn)                                                       | The ARN of our lambda execution role                                         | `string`                                                                                     | n/a            |   yes    |
| <a name="input_lambda_directory"></a> [lambda_directory](#input_lambda_directory)                                           | The directory where our artifacts are stored in S3                           | `string`                                                                                     | n/a            |   yes    |
| <a name="input_lambda_runtime"></a> [lambda_runtime](#input_lambda_runtime)                                                 | The runtime we want use for the lambda                                       | `string`                                                                                     | `"nodejs16.x"` |    no    |
| <a name="input_memory_size"></a> [memory_size](#input_memory_size)                                                          | The memory size of the lambda                                                | `number`                                                                                     | `256`          |    no    |
| <a name="input_override_function_name"></a> [override_function_name](#input_override_function_name)                         | Do we want to override the generated function name                           | `bool`                                                                                       | `false`        |    no    |
| <a name="input_reserved_concurrent_executions"></a> [reserved_concurrent_executions](#input_reserved_concurrent_executions) | Amount of reserved concurrent executions for this lambda function            | `number`                                                                                     | `-1`           |    no    |
| <a name="input_resource_prefix"></a> [resource_prefix](#input_resource_prefix)                                              | A prefix for our function name for multi environment deployments             | `string`                                                                                     | n/a            |   yes    |
| <a name="input_tags"></a> [tags](#input_tags)                                                                               | A map of tags for this object                                                | `map(string)`                                                                                | `{}`           |    no    |
| <a name="input_timeout"></a> [timeout](#input_timeout)                                                                      | Execution timeout in seconds for this lambda function                        | `number`                                                                                     | `30`           |    no    |
| <a name="input_vpc_config"></a> [vpc_config](#input_vpc_config)                                                             | The configuration values to connect the Lambda to a VPC                      | <pre>object({<br> subnet_ids = set(string)<br> security_group_ids = set(string)<br> })</pre> | `null`         |    no    |

## Outputs

| Name                                                                                                                    | Description                                        |
| ----------------------------------------------------------------------------------------------------------------------- | -------------------------------------------------- |
| <a name="output_function_name"></a> [function_name](#output_function_name)                                              | The name of the Lambda Function                    |
| <a name="output_function_name_without_prefix"></a> [function_name_without_prefix](#output_function_name_without_prefix) | The name of the Lambda Function without the prefix |
| <a name="output_lambda_arn"></a> [lambda_arn](#output_lambda_arn)                                                       | The ARN of the Lambda Function                     |

<!-- END_TF_DOCS -->
