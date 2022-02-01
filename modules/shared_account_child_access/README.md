# Shared Account Child Access

Creates roles and shared resources for the parent account to assume on the child

### Pre-requisites
The CI username needs to be created as a ssm parameter on the parent account under the path `/users/system/ci`

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.13 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | = 3.72.0 |
| <a name="requirement_template"></a> [template](#requirement\_template) | = 2.2.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 3.72.0 |
| <a name="provider_template"></a> [template](#provider\_template) | 2.2.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_aws_logs"></a> [aws\_logs](#module\_aws\_logs) | trussworks/logs/aws | ~> 10.3.0  |

## Resources

| Name | Type |
|------|------|
| [aws_iam_policy.ci_permissions_policy_part1](https://registry.terraform.io/providers/hashicorp/aws/3.72.0/docs/resources/iam_policy) | resource |
| [aws_iam_policy.ci_permissions_policy_part2](https://registry.terraform.io/providers/hashicorp/aws/3.72.0/docs/resources/iam_policy) | resource |
| [aws_iam_policy.ci_policy](https://registry.terraform.io/providers/hashicorp/aws/3.72.0/docs/resources/iam_policy) | resource |
| [aws_iam_policy.ci_to_parent_policy](https://registry.terraform.io/providers/hashicorp/aws/3.72.0/docs/resources/iam_policy) | resource |
| [aws_iam_policy.deny_ci_permissions_policy](https://registry.terraform.io/providers/hashicorp/aws/3.72.0/docs/resources/iam_policy) | resource |
| [aws_iam_role.assume_administrator_access](https://registry.terraform.io/providers/hashicorp/aws/3.72.0/docs/resources/iam_role) | resource |
| [aws_iam_role.assume_aws_nuke_access](https://registry.terraform.io/providers/hashicorp/aws/3.72.0/docs/resources/iam_role) | resource |
| [aws_iam_role.assume_ci_access](https://registry.terraform.io/providers/hashicorp/aws/3.72.0/docs/resources/iam_role) | resource |
| [aws_iam_role.assume_readonly_access](https://registry.terraform.io/providers/hashicorp/aws/3.72.0/docs/resources/iam_role) | resource |
| [aws_iam_role.portal_host_lambda_role](https://registry.terraform.io/providers/hashicorp/aws/3.72.0/docs/resources/iam_role) | resource |
| [aws_iam_role_policy.allow_role_scoutsuite_read](https://registry.terraform.io/providers/hashicorp/aws/3.72.0/docs/resources/iam_role_policy) | resource |
| [aws_iam_role_policy.nuke_policy_1](https://registry.terraform.io/providers/hashicorp/aws/3.72.0/docs/resources/iam_role_policy) | resource |
| [aws_iam_role_policy.nuke_policy_2](https://registry.terraform.io/providers/hashicorp/aws/3.72.0/docs/resources/iam_role_policy) | resource |
| [aws_iam_role_policy.nuke_policy_3](https://registry.terraform.io/providers/hashicorp/aws/3.72.0/docs/resources/iam_role_policy) | resource |
| [aws_iam_role_policy.nuke_policy_4](https://registry.terraform.io/providers/hashicorp/aws/3.72.0/docs/resources/iam_role_policy) | resource |
| [aws_iam_role_policy_attachment.administrator_access_policy_attachment](https://registry.terraform.io/providers/hashicorp/aws/3.72.0/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.ci_access_policy_attachment_part1](https://registry.terraform.io/providers/hashicorp/aws/3.72.0/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.ci_access_policy_attachment_part2](https://registry.terraform.io/providers/hashicorp/aws/3.72.0/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.ci_parent_access_policy_attachment](https://registry.terraform.io/providers/hashicorp/aws/3.72.0/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.ci_policies](https://registry.terraform.io/providers/hashicorp/aws/3.72.0/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.deny_ci_permissions_policy_attachment](https://registry.terraform.io/providers/hashicorp/aws/3.72.0/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.readonly_access_policy_attachment](https://registry.terraform.io/providers/hashicorp/aws/3.72.0/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_service_linked_role.es_service_role](https://registry.terraform.io/providers/hashicorp/aws/3.72.0/docs/resources/iam_service_linked_role) | resource |
| [aws_s3_bucket.account_logging_bucket](https://registry.terraform.io/providers/hashicorp/aws/3.72.0/docs/resources/s3_bucket) | resource |
| [aws_s3_bucket_policy.account_logging_bucket](https://registry.terraform.io/providers/hashicorp/aws/3.72.0/docs/resources/s3_bucket_policy) | resource |
| [aws_s3_bucket_public_access_block.account_logging_bucket](https://registry.terraform.io/providers/hashicorp/aws/3.72.0/docs/resources/s3_bucket_public_access_block) | resource |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/3.72.0/docs/data-sources/caller_identity) | data source |
| [aws_region.current_region](https://registry.terraform.io/providers/hashicorp/aws/3.72.0/docs/data-sources/region) | data source |
| [template_file.allow_assume_administrator_access_template](https://registry.terraform.io/providers/hashicorp/template/2.2.0/docs/data-sources/file) | data source |
| [template_file.allow_assume_aws_nuke_access](https://registry.terraform.io/providers/hashicorp/template/2.2.0/docs/data-sources/file) | data source |
| [template_file.allow_assume_ci_access_template](https://registry.terraform.io/providers/hashicorp/template/2.2.0/docs/data-sources/file) | data source |
| [template_file.allow_assume_readonly_access_template](https://registry.terraform.io/providers/hashicorp/template/2.2.0/docs/data-sources/file) | data source |
| [template_file.ci_policy_document_part1](https://registry.terraform.io/providers/hashicorp/template/2.2.0/docs/data-sources/file) | data source |
| [template_file.ci_policy_document_part2](https://registry.terraform.io/providers/hashicorp/template/2.2.0/docs/data-sources/file) | data source |
| [template_file.ci_to_parent_policy_template](https://registry.terraform.io/providers/hashicorp/template/2.2.0/docs/data-sources/file) | data source |
| [template_file.deny_ci_permissions_policy](https://registry.terraform.io/providers/hashicorp/template/2.2.0/docs/data-sources/file) | data source |
| [template_file.deny_non_tls_s3_comms_on_logging_bucket](https://registry.terraform.io/providers/hashicorp/template/2.2.0/docs/data-sources/file) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_bucket_name"></a> [bucket\_name](#input\_bucket\_name) | The name of the shared bucket | `string` | n/a | yes |
| <a name="input_create_nuke_user"></a> [create\_nuke\_user](#input\_create\_nuke\_user) | Do we want to create user to run AWS Nuke with | `bool` | `false` | no |
| <a name="input_denied_user_arns"></a> [denied\_user\_arns](#input\_denied\_user\_arns) | A list of arns that cannot assume roles | `list(string)` | `[]` | no |
| <a name="input_logging_bucket_name"></a> [logging\_bucket\_name](#input\_logging\_bucket\_name) | The name of the shared logging bucket | `string` | n/a | yes |
| <a name="input_root_account_id"></a> [root\_account\_id](#input\_root\_account\_id) | The ID of the parent account | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of tags to apply to our shared accounts | `map` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_administrator_access_role"></a> [administrator\_access\_role](#output\_administrator\_access\_role) | The administrator access role outputs |
| <a name="output_aws_nuke_access_role"></a> [aws\_nuke\_access\_role](#output\_aws\_nuke\_access\_role) | The aws\_nuke access role outputs |
| <a name="output_ci_access_role"></a> [ci\_access\_role](#output\_ci\_access\_role) | The ci access role outputs |
| <a name="output_readonly_access_role"></a> [readonly\_access\_role](#output\_readonly\_access\_role) | The readonly access role outputs |
<!-- END_TF_DOCS -->
