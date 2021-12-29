# Shared account parent access

Module to allow groups to assume roles on child accounts

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
| [aws_iam_group_policy_attachment.administrator_access_policy_attachment](https://registry.terraform.io/providers/hashicorp/aws/3.56.0/docs/resources/iam_group_policy_attachment) | resource |
| [aws_iam_group_policy_attachment.ci_access_policy_attachment](https://registry.terraform.io/providers/hashicorp/aws/3.56.0/docs/resources/iam_group_policy_attachment) | resource |
| [aws_iam_group_policy_attachment.readonly_access_policy_attachment](https://registry.terraform.io/providers/hashicorp/aws/3.56.0/docs/resources/iam_group_policy_attachment) | resource |
| [aws_iam_policy.allow_assume_administrator_access_role](https://registry.terraform.io/providers/hashicorp/aws/3.56.0/docs/resources/iam_policy) | resource |
| [aws_iam_policy.allow_assume_ci_access_role](https://registry.terraform.io/providers/hashicorp/aws/3.56.0/docs/resources/iam_policy) | resource |
| [aws_iam_policy.allow_assume_readonly_access_role](https://registry.terraform.io/providers/hashicorp/aws/3.56.0/docs/resources/iam_policy) | resource |
| [template_file.allow_assume_administrator_access](https://registry.terraform.io/providers/hashicorp/template/2.2.0/docs/data-sources/file) | data source |
| [template_file.allow_assume_ci_access](https://registry.terraform.io/providers/hashicorp/template/2.2.0/docs/data-sources/file) | data source |
| [template_file.allow_assume_readonly_access](https://registry.terraform.io/providers/hashicorp/template/2.2.0/docs/data-sources/file) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_admin_access_arn"></a> [admin\_access\_arn](#input\_admin\_access\_arn) | The child admin assume role arn | `string` | n/a | yes |
| <a name="input_admin_access_group_name"></a> [admin\_access\_group\_name](#input\_admin\_access\_group\_name) | The name of the admin group | `string` | n/a | yes |
| <a name="input_child_account_id"></a> [child\_account\_id](#input\_child\_account\_id) | The child accounts id | `string` | n/a | yes |
| <a name="input_ci_access_arn"></a> [ci\_access\_arn](#input\_ci\_access\_arn) | The child ci assume role arn | `string` | n/a | yes |
| <a name="input_ci_access_group_name"></a> [ci\_access\_group\_name](#input\_ci\_access\_group\_name) | The name of the CI group | `string` | n/a | yes |
| <a name="input_readonly_access_arn"></a> [readonly\_access\_arn](#input\_readonly\_access\_arn) | The child readonly assume role arn | `string` | n/a | yes |
| <a name="input_readonly_access_group_name"></a> [readonly\_access\_group\_name](#input\_readonly\_access\_group\_name) | The name of the readonly group | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_assume_ci_access_arn"></a> [assume\_ci\_access\_arn](#output\_assume\_ci\_access\_arn) | n/a |
<!-- END_TF_DOCS -->