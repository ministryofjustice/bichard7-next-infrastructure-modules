<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.13 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | = 3.75.2 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_archive"></a> [archive](#provider\_archive) | 2.2.0 |
| <a name="provider_aws"></a> [aws](#provider\_aws) | 3.72.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_iam_role.slack_webhook_notification](https://registry.terraform.io/providers/hashicorp/aws/3.75.2/docs/resources/iam_role) | resource |
| [aws_kms_alias.slack_webhook_notifications_key_alias](https://registry.terraform.io/providers/hashicorp/aws/3.75.2/docs/resources/kms_alias) | resource |
| [aws_kms_key.slack_webhook_notifications_key](https://registry.terraform.io/providers/hashicorp/aws/3.75.2/docs/resources/kms_key) | resource |
| [aws_lambda_function.slack_webhook_notification](https://registry.terraform.io/providers/hashicorp/aws/3.75.2/docs/resources/lambda_function) | resource |
| [aws_lambda_permission.slack_webhook_notification](https://registry.terraform.io/providers/hashicorp/aws/3.75.2/docs/resources/lambda_permission) | resource |
| [aws_sns_topic.slack_webhook_notifications](https://registry.terraform.io/providers/hashicorp/aws/3.75.2/docs/resources/sns_topic) | resource |
| [aws_sns_topic_policy.default](https://registry.terraform.io/providers/hashicorp/aws/3.75.2/docs/resources/sns_topic_policy) | resource |
| [aws_sns_topic_subscription.slack_webhook_subscription](https://registry.terraform.io/providers/hashicorp/aws/3.75.2/docs/resources/sns_topic_subscription) | resource |
| [archive_file.slack_webhook_notification](https://registry.terraform.io/providers/hashicorp/archive/latest/docs/data-sources/file) | data source |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/3.75.2/docs/data-sources/caller_identity) | data source |
| [aws_iam_policy.allow_lambda_to_log](https://registry.terraform.io/providers/hashicorp/aws/3.75.2/docs/data-sources/iam_policy) | data source |
| [aws_region.current](https://registry.terraform.io/providers/hashicorp/aws/3.75.2/docs/data-sources/region) | data source |
| [aws_ssm_parameter.slack_webhook](https://registry.terraform.io/providers/hashicorp/aws/3.75.2/docs/data-sources/ssm_parameter) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_name"></a> [name](#input\_name) | Our resource name | `string` | n/a | yes |
| <a name="input_notifications_channel_name"></a> [notifications\_channel\_name](#input\_notifications\_channel\_name) | Our slack channel for build notifications | `string` | `"moj-cjse-bichard-notifications"` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of resource tags | `map(string)` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_slack_sns_topic"></a> [slack\_sns\_topic](#output\_slack\_sns\_topic) | The slack webook sns topic |
<!-- END_TF_DOCS -->
