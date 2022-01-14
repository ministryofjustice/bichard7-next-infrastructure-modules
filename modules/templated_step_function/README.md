# Templated Step Function

Creates a step function based on deployed lambdas

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
| <a name="provider_template"></a> [template](#provider\_template) | 2.2.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_sfn_state_machine.step_function](https://registry.terraform.io/providers/hashicorp/aws/3.72.0/docs/resources/sfn_state_machine) | resource |
| [aws_s3_bucket_object.state_machine_definition_template](https://registry.terraform.io/providers/hashicorp/aws/3.72.0/docs/data-sources/s3_bucket_object) | data source |
| [template_file.state_machine_definition](https://registry.terraform.io/providers/hashicorp/template/latest/docs/data-sources/file) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cloud_watch_logs_group_arn"></a> [cloud\_watch\_logs\_group\_arn](#input\_cloud\_watch\_logs\_group\_arn) | The ARN of Cloudwatch logs group | `string` | n/a | yes |
| <a name="input_iam_role_arn"></a> [iam\_role\_arn](#input\_iam\_role\_arn) | The ARN of the IAM Role to attach to the Step Function | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | The name of the Step Function | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags to apply to all created resources | `map(string)` | n/a | yes |
| <a name="input_template_file_bucket"></a> [template\_file\_bucket](#input\_template\_file\_bucket) | The name of the bucket in the parent account that contains the template file | `string` | n/a | yes |
| <a name="input_template_file_key"></a> [template\_file\_key](#input\_template\_file\_key) | The template file key for the S3 object in the bucket | `string` | n/a | yes |
| <a name="input_template_variables"></a> [template\_variables](#input\_template\_variables) | The keyed variables to replace in the template file | `map(string)` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_state_machine_definition"></a> [state\_machine\_definition](#output\_state\_machine\_definition) | The rendered output of the state machine definition file |
| <a name="output_step_function_arn"></a> [step\_function\_arn](#output\_step\_function\_arn) | The ARN of the Step Function |
<!-- END_TF_DOCS -->
