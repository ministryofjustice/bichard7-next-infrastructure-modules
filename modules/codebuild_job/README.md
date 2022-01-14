# Codebuild Job

Opinionated module that sets up a codebuild job and related notifications. Notifications default to failures only but can
be overridden. If the notifications variable is empty we won't create the notifications submodule

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.13 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | = 3.72.0 |
| <a name="requirement_local"></a> [local](#requirement\_local) | = 2.0.0 |
| <a name="requirement_template"></a> [template](#requirement\_template) | = 2.2.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 3.72.0 |
| <a name="provider_template"></a> [template](#provider\_template) | 2.2.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_codebuild_pipeline_notification"></a> [codebuild\_pipeline\_notification](#module\_codebuild\_pipeline\_notification) | ../codestar_notification | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_codebuild_project.cb_project](https://registry.terraform.io/providers/hashicorp/aws/3.72.0/docs/resources/codebuild_project) | resource |
| [aws_iam_policy.codebuild_allow_ecr](https://registry.terraform.io/providers/hashicorp/aws/3.72.0/docs/resources/iam_policy) | resource |
| [aws_iam_role.service_role](https://registry.terraform.io/providers/hashicorp/aws/3.72.0/docs/resources/iam_role) | resource |
| [aws_iam_role_policy.codebuild_role_extra_policies](https://registry.terraform.io/providers/hashicorp/aws/3.72.0/docs/resources/iam_role_policy) | resource |
| [aws_iam_role_policy_attachment.codebuild_allow_ecr](https://registry.terraform.io/providers/hashicorp/aws/3.72.0/docs/resources/iam_role_policy_attachment) | resource |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/3.72.0/docs/data-sources/caller_identity) | data source |
| [aws_iam_group.ci_user_group](https://registry.terraform.io/providers/hashicorp/aws/3.72.0/docs/data-sources/iam_group) | data source |
| [aws_region.current](https://registry.terraform.io/providers/hashicorp/aws/3.72.0/docs/data-sources/region) | data source |
| [aws_ssm_parameter.access_key_id](https://registry.terraform.io/providers/hashicorp/aws/3.72.0/docs/data-sources/ssm_parameter) | data source |
| [aws_ssm_parameter.secret_access_key](https://registry.terraform.io/providers/hashicorp/aws/3.72.0/docs/data-sources/ssm_parameter) | data source |
| [template_file.allow_resources](https://registry.terraform.io/providers/hashicorp/template/2.2.0/docs/data-sources/file) | data source |
| [template_file.codebuild_policy](https://registry.terraform.io/providers/hashicorp/template/2.2.0/docs/data-sources/file) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_allowed_resource_arns"></a> [allowed\_resource\_arns](#input\_allowed\_resource\_arns) | A list of resource arns that we are allowed access too | `list(string)` | `[]` | no |
| <a name="input_aws_access_key_id_ssm_path"></a> [aws\_access\_key\_id\_ssm\_path](#input\_aws\_access\_key\_id\_ssm\_path) | Path to our ssm access key | `string` | `"/ci/user/access_key_id"` | no |
| <a name="input_aws_secret_access_key_ssm_path"></a> [aws\_secret\_access\_key\_ssm\_path](#input\_aws\_secret\_access\_key\_ssm\_path) | Path to access to our smm secret access key | `string` | `"/ci/user/secret_access_key"` | no |
| <a name="input_build_description"></a> [build\_description](#input\_build\_description) | The description of our build job | `string` | n/a | yes |
| <a name="input_build_environments"></a> [build\_environments](#input\_build\_environments) | A list of maps of our build environments | `list(map(string))` | <pre>[<br>  {<br>    "compute_type": "BUILD_GENERAL1_SMALL",<br>    "image": "aws/codebuild/amazonlinux2-x86_64-standard:3.0",<br>    "privileged_mode": true,<br>    "type": "LINUX_CONTAINER"<br>  }<br>]</pre> | no |
| <a name="input_build_timeout"></a> [build\_timeout](#input\_build\_timeout) | How long, in minutes, before we terminate our build as non responsive | `number` | `180` | no |
| <a name="input_buildspec_file"></a> [buildspec\_file](#input\_buildspec\_file) | The name and path of our buildspec file | `string` | `"buildspec.yml"` | no |
| <a name="input_codebuild_secondary_sources"></a> [codebuild\_secondary\_sources](#input\_codebuild\_secondary\_sources) | A list of secondary source maps | `any` | `{}` | no |
| <a name="input_codepipeline_s3_bucket"></a> [codepipeline\_s3\_bucket](#input\_codepipeline\_s3\_bucket) | Our shared bucket for codepipeline | `string` | n/a | yes |
| <a name="input_deploy_account_name"></a> [deploy\_account\_name](#input\_deploy\_account\_name) | The deployment account name for CD usage, required only if is\_cd is true | `string` | `""` | no |
| <a name="input_deployment_name"></a> [deployment\_name](#input\_deployment\_name) | The deployment-name for CD usage, required only if is\_cd is true | `string` | `""` | no |
| <a name="input_environment_variables"></a> [environment\_variables](#input\_environment\_variables) | A list of maps of our environment variables type can be unset | `list(map(string))` | `[]` | no |
| <a name="input_event_type_ids"></a> [event\_type\_ids](#input\_event\_type\_ids) | A list of event types we want to notify on | `list(string)` | <pre>[<br>  "codebuild-project-build-state-failed"<br>]</pre> | no |
| <a name="input_git_ref"></a> [git\_ref](#input\_git\_ref) | The git reference we want to use | `string` | `"master"` | no |
| <a name="input_is_cd"></a> [is\_cd](#input\_is\_cd) | Is this a CI/CD environment | `bool` | `false` | no |
| <a name="input_name"></a> [name](#input\_name) | Our resource name | `string` | n/a | yes |
| <a name="input_report_build_status"></a> [report\_build\_status](#input\_report\_build\_status) | Do we want to report the build status upstream | `bool` | `false` | no |
| <a name="input_repository_name"></a> [repository\_name](#input\_repository\_name) | The name of our primary repository to clone from ie bichard7-next | `string` | n/a | yes |
| <a name="input_sns_kms_key_arn"></a> [sns\_kms\_key\_arn](#input\_sns\_kms\_key\_arn) | The arn for our encryption key for sns | `string` | n/a | yes |
| <a name="input_sns_notification_arn"></a> [sns\_notification\_arn](#input\_sns\_notification\_arn) | The arn of our build queue | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of resource tags | `map(string)` | n/a | yes |
| <a name="input_vpc_config"></a> [vpc\_config](#input\_vpc\_config) | The config for our codebuild vpc | `any` | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_pipeline_arn"></a> [pipeline\_arn](#output\_pipeline\_arn) | The arn of our code pipeline |
| <a name="output_pipeline_id"></a> [pipeline\_id](#output\_pipeline\_id) | The id of our code pipeline |
| <a name="output_pipeline_name"></a> [pipeline\_name](#output\_pipeline\_name) | The name of our code pipeline |
| <a name="output_pipeline_service_role_name"></a> [pipeline\_service\_role\_name](#output\_pipeline\_service\_role\_name) | The name of the service role so we can attach policies if needed |
<!-- END_TF_DOCS -->
