# AmazonMQ Lambda Trigger

Configures a lambda to be a consumer of an AmazonMQ queue

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.13 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | = 3.56.0 |
| <a name="requirement_null"></a> [null](#requirement\_null) | = 3.0.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_null"></a> [null](#provider\_null) | 3.0.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [null_resource.setup_event_listener](https://registry.terraform.io/providers/hashicorp/null/3.0.0/docs/resources/resource) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_assume_role_arn"></a> [assume\_role\_arn](#input\_assume\_role\_arn) | The ARN of the IAM Role to assume for the trigger | `string` | n/a | yes |
| <a name="input_lambda_arn"></a> [lambda\_arn](#input\_lambda\_arn) | The ARN of the AWS Lambda Function to which to attach the trigger | `string` | n/a | yes |
| <a name="input_queue_arn"></a> [queue\_arn](#input\_queue\_arn) | The ARN of the AmazonMQ Queue to which to subscribe | `string` | n/a | yes |
| <a name="input_queue_name"></a> [queue\_name](#input\_queue\_name) | The name of the AmazonMQ Queue to which to subscribe | `string` | n/a | yes |
| <a name="input_queue_secret_arn"></a> [queue\_secret\_arn](#input\_queue\_secret\_arn) | The ARN of the AWS Secrets Manager Secret that contains the username and password for the AmazonMQ broker | `string` | n/a | yes |
| <a name="input_region_id"></a> [region\_id](#input\_region\_id) | The Id of the current AWS Region | `string` | n/a | yes |

## Outputs

No outputs.
<!-- END_TF_DOCS -->
