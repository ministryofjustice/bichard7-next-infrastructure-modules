# Codebuild Webhook

Module that allows codebuild to create a cloudwatch event trigger so builds can run on a schedule

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.13 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | = 3.72.0 |
| <a name="requirement_external"></a> [external](#requirement\_external) | = 2.1.0 |
| <a name="requirement_local"></a> [local](#requirement\_local) | = 2.0.0 |
| <a name="requirement_template"></a> [template](#requirement\_template) | = 2.2.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | = 3.72.0 |
| <a name="provider_template"></a> [template](#provider\_template) | = 2.2.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_cloudwatch_event_rule.trigger_codebuild_build](https://registry.terraform.io/providers/hashicorp/aws/3.72.0/docs/resources/cloudwatch_event_rule) | resource |
| [aws_cloudwatch_event_target.trigger_codebuild_build_target](https://registry.terraform.io/providers/hashicorp/aws/3.72.0/docs/resources/cloudwatch_event_target) | resource |
| [aws_iam_role.trigger_codebuild_build_role](https://registry.terraform.io/providers/hashicorp/aws/3.72.0/docs/resources/iam_role) | resource |
| [aws_iam_role_policy.trigger_codebuild_build_policy](https://registry.terraform.io/providers/hashicorp/aws/3.72.0/docs/resources/iam_role_policy) | resource |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/3.72.0/docs/data-sources/caller_identity) | data source |
| [aws_region.current](https://registry.terraform.io/providers/hashicorp/aws/3.72.0/docs/data-sources/region) | data source |
| [template_file.cloudwatch_event_policy](https://registry.terraform.io/providers/hashicorp/template/2.2.0/docs/data-sources/file) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_codebuild_arn"></a> [codebuild\_arn](#input\_codebuild\_arn) | The arn of our codebuild project we want to be triggered from cloudwatch | `string` | n/a | yes |
| <a name="input_cron_expression"></a> [cron\_expression](#input\_cron\_expression) | Our cron expression for our job | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | The name of the event trigger, we should use the build name so it's easier to match | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of resource tags | `map(string)` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_cloudwatch_event_rule"></a> [cloudwatch\_event\_rule](#output\_cloudwatch\_event\_rule) | Our cloudwatch event |
| <a name="output_cloudwatch_event_target"></a> [cloudwatch\_event\_target](#output\_cloudwatch\_event\_target) | Our event target |
<!-- END_TF_DOCS -->
