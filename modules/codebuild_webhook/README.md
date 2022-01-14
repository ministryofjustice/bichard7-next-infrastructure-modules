# Codebuild Webhook

Module that allows codebuild to create a github webhook

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

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_codebuild_webhook.trigger_build](https://registry.terraform.io/providers/hashicorp/aws/3.72.0/docs/resources/codebuild_webhook) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_codebuild_project_name"></a> [codebuild\_project\_name](#input\_codebuild\_project\_name) | The name of the codebuild project we want to attach this webhook to | `string` | n/a | yes |
| <a name="input_filter_event_pattern"></a> [filter\_event\_pattern](#input\_filter\_event\_pattern) | The pattern we're using to filter this event | `string` | `"PUSH"` | no |
| <a name="input_filter_event_type"></a> [filter\_event\_type](#input\_filter\_event\_type) | The type of event we're triggering this webhook with | `string` | `"EVENT"` | no |
| <a name="input_git_ref"></a> [git\_ref](#input\_git\_ref) | Our git ref that we want to use for our trigger | `string` | `"master"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_codebuild_webhook"></a> [codebuild\_webhook](#output\_codebuild\_webhook) | The outputs from our codebuild webhook |
<!-- END_TF_DOCS -->
