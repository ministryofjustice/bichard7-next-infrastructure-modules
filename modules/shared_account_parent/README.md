# Shared Account Parent

Module to set up roles and shared resources on an AWS parent account

### Pre-requisites
The CI username needs to be created as a ssm parameter on the parent account under the path `/users/system/ci`

If you want to create a user for AWS Nuke, the variable create_nuke_user needs to be set to true and we need a ssm parameter under the path
`/users/system/aws_nuke`

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.13 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | = 3.56.0 |
| <a name="requirement_template"></a> [template](#requirement\_template) | = 2.2.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 3.56.0 |
| <a name="provider_template"></a> [template](#provider\_template) | 2.2.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_iam_access_key.ci_user_key](https://registry.terraform.io/providers/hashicorp/aws/3.56.0/docs/resources/iam_access_key) | resource |
| [aws_iam_access_key.nuke_user_key](https://registry.terraform.io/providers/hashicorp/aws/3.56.0/docs/resources/iam_access_key) | resource |
| [aws_iam_group.administrator_access_group](https://registry.terraform.io/providers/hashicorp/aws/3.56.0/docs/resources/iam_group) | resource |
| [aws_iam_group.aws_nuke_group](https://registry.terraform.io/providers/hashicorp/aws/3.56.0/docs/resources/iam_group) | resource |
| [aws_iam_group.ci_access_group](https://registry.terraform.io/providers/hashicorp/aws/3.56.0/docs/resources/iam_group) | resource |
| [aws_iam_group.mfa_group](https://registry.terraform.io/providers/hashicorp/aws/3.56.0/docs/resources/iam_group) | resource |
| [aws_iam_group.readonly_access_group](https://registry.terraform.io/providers/hashicorp/aws/3.56.0/docs/resources/iam_group) | resource |
| [aws_iam_group_policy.ci_user_allow_scoutsuite](https://registry.terraform.io/providers/hashicorp/aws/3.56.0/docs/resources/iam_group_policy) | resource |
| [aws_iam_group_policy_attachment.admin_user_allow_all_policy](https://registry.terraform.io/providers/hashicorp/aws/3.56.0/docs/resources/iam_group_policy_attachment) | resource |
| [aws_iam_group_policy_attachment.allow_ci_ssm_read_only](https://registry.terraform.io/providers/hashicorp/aws/3.56.0/docs/resources/iam_group_policy_attachment) | resource |
| [aws_iam_group_policy_attachment.ci_group_policy](https://registry.terraform.io/providers/hashicorp/aws/3.56.0/docs/resources/iam_group_policy_attachment) | resource |
| [aws_iam_group_policy_attachment.force_mfa](https://registry.terraform.io/providers/hashicorp/aws/3.56.0/docs/resources/iam_group_policy_attachment) | resource |
| [aws_iam_group_policy_attachment.readonly_user_policy](https://registry.terraform.io/providers/hashicorp/aws/3.56.0/docs/resources/iam_group_policy_attachment) | resource |
| [aws_iam_policy.ci_policy](https://registry.terraform.io/providers/hashicorp/aws/3.56.0/docs/resources/iam_policy) | resource |
| [aws_iam_policy.mfa_policy](https://registry.terraform.io/providers/hashicorp/aws/3.56.0/docs/resources/iam_policy) | resource |
| [aws_iam_role.assume_administrator_access_on_parent](https://registry.terraform.io/providers/hashicorp/aws/3.56.0/docs/resources/iam_role) | resource |
| [aws_iam_role_policy_attachment.administrator_access_policy_attachment](https://registry.terraform.io/providers/hashicorp/aws/3.56.0/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_user.ci_user](https://registry.terraform.io/providers/hashicorp/aws/3.56.0/docs/resources/iam_user) | resource |
| [aws_iam_user.nuke_user](https://registry.terraform.io/providers/hashicorp/aws/3.56.0/docs/resources/iam_user) | resource |
| [aws_iam_user_group_membership.ci_user](https://registry.terraform.io/providers/hashicorp/aws/3.56.0/docs/resources/iam_user_group_membership) | resource |
| [aws_iam_user_group_membership.nuke_user](https://registry.terraform.io/providers/hashicorp/aws/3.56.0/docs/resources/iam_user_group_membership) | resource |
| [aws_iam_user_policy.allow_ci_codebuild_all](https://registry.terraform.io/providers/hashicorp/aws/3.56.0/docs/resources/iam_user_policy) | resource |
| [aws_ssm_parameter.ci_user_access_key_id](https://registry.terraform.io/providers/hashicorp/aws/3.56.0/docs/resources/ssm_parameter) | resource |
| [aws_ssm_parameter.ci_user_secret_access_key](https://registry.terraform.io/providers/hashicorp/aws/3.56.0/docs/resources/ssm_parameter) | resource |
| [aws_ssm_parameter.nuke_user_access_key_id](https://registry.terraform.io/providers/hashicorp/aws/3.56.0/docs/resources/ssm_parameter) | resource |
| [aws_ssm_parameter.nuke_user_secret_access_key](https://registry.terraform.io/providers/hashicorp/aws/3.56.0/docs/resources/ssm_parameter) | resource |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/3.56.0/docs/data-sources/caller_identity) | data source |
| [aws_ssm_parameter.aws_nuke_user](https://registry.terraform.io/providers/hashicorp/aws/3.56.0/docs/data-sources/ssm_parameter) | data source |
| [aws_ssm_parameter.ci_user](https://registry.terraform.io/providers/hashicorp/aws/3.56.0/docs/data-sources/ssm_parameter) | data source |
| [template_file.allow_assume_administrator_access_template](https://registry.terraform.io/providers/hashicorp/template/2.2.0/docs/data-sources/file) | data source |
| [template_file.allow_assume_aws_nuke_access_template](https://registry.terraform.io/providers/hashicorp/template/2.2.0/docs/data-sources/file) | data source |
| [template_file.allow_codebuild_ci](https://registry.terraform.io/providers/hashicorp/template/2.2.0/docs/data-sources/file) | data source |
| [template_file.parent_account_ci_policy](https://registry.terraform.io/providers/hashicorp/template/2.2.0/docs/data-sources/file) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_buckets"></a> [buckets](#input\_buckets) | A list of shared buckets that the parent allows the children to access | `list(string)` | `[]` | no |
| <a name="input_create_nuke_user"></a> [create\_nuke\_user](#input\_create\_nuke\_user) | Do we want to create user to run AWS Nuke with | `bool` | `false` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A list of AWS tags | `map(string)` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_administrator_access_group"></a> [administrator\_access\_group](#output\_administrator\_access\_group) | The name of the admin group |
| <a name="output_ci_access_group"></a> [ci\_access\_group](#output\_ci\_access\_group) | The name of the ci group |
| <a name="output_ci_policy_arn"></a> [ci\_policy\_arn](#output\_ci\_policy\_arn) | The arn of our ci policy |
| <a name="output_ci_users"></a> [ci\_users](#output\_ci\_users) | A list of ci users |
| <a name="output_ci_users_arns"></a> [ci\_users\_arns](#output\_ci\_users\_arns) | A list of ci user arns |
| <a name="output_mfa_group"></a> [mfa\_group](#output\_mfa\_group) | The name of the MFA group |
| <a name="output_nuke_users_arns"></a> [nuke\_users\_arns](#output\_nuke\_users\_arns) | A list of aws nuke user arns |
| <a name="output_readonly_access_group"></a> [readonly\_access\_group](#output\_readonly\_access\_group) | The name of the read-only group |
<!-- END_TF_DOCS -->
