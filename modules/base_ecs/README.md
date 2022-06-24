# Base ECS

Module to configure our basic ecs cluster used for the Bichard Application

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
| <a name="provider_template"></a> [template](#provider\_template) | 2.2.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_ecs_cluster.cluster](https://registry.terraform.io/providers/hashicorp/aws/3.75.2/docs/resources/ecs_cluster) | resource |
| [aws_efs_access_point.prometheus_data](https://registry.terraform.io/providers/hashicorp/aws/3.75.2/docs/resources/efs_access_point) | resource |
| [aws_efs_file_system.ecs_storage](https://registry.terraform.io/providers/hashicorp/aws/3.75.2/docs/resources/efs_file_system) | resource |
| [aws_efs_mount_target.ecs_storage_subnets](https://registry.terraform.io/providers/hashicorp/aws/3.75.2/docs/resources/efs_mount_target) | resource |
| [aws_iam_role_policy.allow_admin_role_cmk_access](https://registry.terraform.io/providers/hashicorp/aws/3.75.2/docs/resources/iam_role_policy) | resource |
| [aws_kms_alias.aurora_cluster_encryption_key_alias](https://registry.terraform.io/providers/hashicorp/aws/3.75.2/docs/resources/kms_alias) | resource |
| [aws_kms_alias.cluster_logs_encryption_key](https://registry.terraform.io/providers/hashicorp/aws/3.75.2/docs/resources/kms_alias) | resource |
| [aws_kms_key.cluster_logs_encryption_key](https://registry.terraform.io/providers/hashicorp/aws/3.75.2/docs/resources/kms_key) | resource |
| [aws_kms_key.efs_encryption_key](https://registry.terraform.io/providers/hashicorp/aws/3.75.2/docs/resources/kms_key) | resource |
| [aws_security_group.ecs_to_efs](https://registry.terraform.io/providers/hashicorp/aws/3.75.2/docs/resources/security_group) | resource |
| [aws_ssm_parameter.bichard7_deploy_tag](https://registry.terraform.io/providers/hashicorp/aws/3.75.2/docs/resources/ssm_parameter) | resource |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/3.75.2/docs/data-sources/caller_identity) | data source |
| [aws_iam_role.admin_role](https://registry.terraform.io/providers/hashicorp/aws/3.75.2/docs/data-sources/iam_role) | data source |
| [template_file.allow_admin_cmk_access](https://registry.terraform.io/providers/hashicorp/template/latest/docs/data-sources/file) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_admin_allowed_cidr"></a> [admin\_allowed\_cidr](#input\_admin\_allowed\_cidr) | A list of cidrs allowed to access ECS | `list(string)` | n/a | yes |
| <a name="input_bichard_deploy_tag"></a> [bichard\_deploy\_tag](#input\_bichard\_deploy\_tag) | The tag of the bichard7 application image to deploy | `string` | n/a | yes |
| <a name="input_log_group_name"></a> [log\_group\_name](#input\_log\_group\_name) | The name of the log group for the ecs cluster | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | The name to be associated with the ECS cluster resources | `string` | n/a | yes |
| <a name="input_override_deploy_tags"></a> [override\_deploy\_tags](#input\_override\_deploy\_tags) | Required for CI/CD, do we want to allow us to overwrite the deploy tag | `bool` | `false` | no |
| <a name="input_service_subnets"></a> [service\_subnets](#input\_service\_subnets) | A list of subnets used by ECS | `list(string)` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of tags used in ecs | `map(string)` | n/a | yes |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | The vpc id | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_bichard_cluster_kms_key_arn"></a> [bichard\_cluster\_kms\_key\_arn](#output\_bichard\_cluster\_kms\_key\_arn) | The ARN of the KMS encryption key |
| <a name="output_bichard_deploy_tag_ssm"></a> [bichard\_deploy\_tag\_ssm](#output\_bichard\_deploy\_tag\_ssm) | The sha256 hash for our docker image |
| <a name="output_bichard_deploy_tag_ssm_arn"></a> [bichard\_deploy\_tag\_ssm\_arn](#output\_bichard\_deploy\_tag\_ssm\_arn) | The arn for the sha256 has for our docker image |
| <a name="output_cluster_id"></a> [cluster\_id](#output\_cluster\_id) | The fargate cluster id |
| <a name="output_cluster_name"></a> [cluster\_name](#output\_cluster\_name) | The fargate cluster name |
| <a name="output_efs_access_points"></a> [efs\_access\_points](#output\_efs\_access\_points) | Our efs access point |
| <a name="output_efs_file_system_id"></a> [efs\_file\_system\_id](#output\_efs\_file\_system\_id) | The efs file system id we have created for ecs |
| <a name="output_efs_mount_targets"></a> [efs\_mount\_targets](#output\_efs\_mount\_targets) | A list of our efs mount target ids |
| <a name="output_security_group_ids"></a> [security\_group\_ids](#output\_security\_group\_ids) | A map of security group ids |
<!-- END_TF_DOCS -->
