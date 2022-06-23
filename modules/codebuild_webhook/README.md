# Codebuild Webhook

Module that allows codebuild to create a github webhook

Terraform is non deterministic with these webhooks and as such can't see if they no longer exist or are invalid in github.

To refresh them we need to do the following:-
 - Log into github, under settings/webhooks in the repository delete the aws codebuild webhooks
 - in the relevant shared infra ci layer run the following
 - ```shell
   $ aws-vault exec bichard7-<shared account suffix> # This will create a subshell with your aws vault credentials
   $ terraform init --upgrade
   $ terraform state list | grep aws_codebuild_webhook # This will give us a list of webhook resources
   # For each item in the list above run the following
   $ terraform taint path.to.aws_codebuild_webhook
   $ exit # to return to your normal shell
   ```
Once all of the resources have been tainted, run the apply-ci-layer job in codebuild

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.13 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | = 3.75.2 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 3.75.2 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_codebuild_webhook.trigger_build](https://registry.terraform.io/providers/hashicorp/aws/3.75.2/docs/resources/codebuild_webhook) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_codebuild_project_name"></a> [codebuild\_project\_name](#input\_codebuild\_project\_name) | The name of the codebuild project we want to attach this webhook to | `string` | n/a | yes |
| <a name="input_filter_event_pattern"></a> [filter\_event\_pattern](#input\_filter\_event\_pattern) | The pattern we're using to filter this event | `string` | `"PUSH"` | no |
| <a name="input_filter_event_type"></a> [filter\_event\_type](#input\_filter\_event\_type) | The type of event we're triggering this webhook with | `string` | `"EVENT"` | no |
| <a name="input_git_ref"></a> [git\_ref](#input\_git\_ref) | Our git ref that we want to use for our trigger | `string` | `"main"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_codebuild_webhook"></a> [codebuild\_webhook](#output\_codebuild\_webhook) | The outputs from our codebuild webhook |
<!-- END_TF_DOCS -->
