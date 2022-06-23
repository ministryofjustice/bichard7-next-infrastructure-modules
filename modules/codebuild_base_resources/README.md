# Codebuild Base Resources

Module to create a set of base resources required for our CD/Codebuild environment

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.13 |
| <a name="requirement_archive"></a> [archive](#requirement\_archive) | = 2.2.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | = 3.75.2 |
| <a name="requirement_template"></a> [template](#requirement\_template) | = 2.2.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_archive"></a> [archive](#provider\_archive) | 2.2.0 |
| <a name="provider_aws"></a> [aws](#provider\_aws) | 3.75.2 |
| <a name="provider_template"></a> [template](#provider\_template) | 2.2.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_vpc"></a> [vpc](#module\_vpc) | terraform-aws-modules/vpc/aws | 3.0.0 |

## Resources

| Name | Type |
|------|------|
| [aws_dynamodb_table.codebuild_lock_table](https://registry.terraform.io/providers/hashicorp/aws/3.75.2/docs/resources/dynamodb_table) | resource |
| [aws_iam_policy.allow_ci_ssm_access](https://registry.terraform.io/providers/hashicorp/aws/3.75.2/docs/resources/iam_policy) | resource |
| [aws_iam_policy.lambda_logging](https://registry.terraform.io/providers/hashicorp/aws/3.75.2/docs/resources/iam_policy) | resource |
| [aws_iam_policy.scanning_lambda_logging](https://registry.terraform.io/providers/hashicorp/aws/3.75.2/docs/resources/iam_policy) | resource |
| [aws_iam_role.codebuild_notification](https://registry.terraform.io/providers/hashicorp/aws/3.75.2/docs/resources/iam_role) | resource |
| [aws_iam_role.scanning_notification](https://registry.terraform.io/providers/hashicorp/aws/3.75.2/docs/resources/iam_role) | resource |
| [aws_iam_role_policy_attachment.lambda_logs](https://registry.terraform.io/providers/hashicorp/aws/3.75.2/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.scanning_lambda_logs](https://registry.terraform.io/providers/hashicorp/aws/3.75.2/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_user_policy.allow_lock_table_access](https://registry.terraform.io/providers/hashicorp/aws/3.75.2/docs/resources/iam_user_policy) | resource |
| [aws_iam_user_policy_attachment.allow_ci_ssm_access](https://registry.terraform.io/providers/hashicorp/aws/3.75.2/docs/resources/iam_user_policy_attachment) | resource |
| [aws_kms_alias.build_notifications_key_alias](https://registry.terraform.io/providers/hashicorp/aws/3.75.2/docs/resources/kms_alias) | resource |
| [aws_kms_alias.remote_state_key_alias](https://registry.terraform.io/providers/hashicorp/aws/3.75.2/docs/resources/kms_alias) | resource |
| [aws_kms_alias.scanning_notifications_key_alias](https://registry.terraform.io/providers/hashicorp/aws/3.75.2/docs/resources/kms_alias) | resource |
| [aws_kms_key.build_notifications_key](https://registry.terraform.io/providers/hashicorp/aws/3.75.2/docs/resources/kms_key) | resource |
| [aws_kms_key.codebuild_lock_table](https://registry.terraform.io/providers/hashicorp/aws/3.75.2/docs/resources/kms_key) | resource |
| [aws_kms_key.scanning_notifications_key](https://registry.terraform.io/providers/hashicorp/aws/3.75.2/docs/resources/kms_key) | resource |
| [aws_lambda_function.codebuild_notification](https://registry.terraform.io/providers/hashicorp/aws/3.75.2/docs/resources/lambda_function) | resource |
| [aws_lambda_function.scanning_notification](https://registry.terraform.io/providers/hashicorp/aws/3.75.2/docs/resources/lambda_function) | resource |
| [aws_lambda_permission.codebuild_notification](https://registry.terraform.io/providers/hashicorp/aws/3.75.2/docs/resources/lambda_permission) | resource |
| [aws_lambda_permission.scanning_notification](https://registry.terraform.io/providers/hashicorp/aws/3.75.2/docs/resources/lambda_permission) | resource |
| [aws_s3_bucket.codebuild_artifact_bucket](https://registry.terraform.io/providers/hashicorp/aws/3.75.2/docs/resources/s3_bucket) | resource |
| [aws_s3_bucket.codebuild_flow_logs_bucket](https://registry.terraform.io/providers/hashicorp/aws/3.75.2/docs/resources/s3_bucket) | resource |
| [aws_s3_bucket.scanning_results_bucket](https://registry.terraform.io/providers/hashicorp/aws/3.75.2/docs/resources/s3_bucket) | resource |
| [aws_s3_bucket_policy.allow_access_to_codebuild_bucket](https://registry.terraform.io/providers/hashicorp/aws/3.75.2/docs/resources/s3_bucket_policy) | resource |
| [aws_s3_bucket_policy.allow_access_to_scanning_results_bucket](https://registry.terraform.io/providers/hashicorp/aws/3.75.2/docs/resources/s3_bucket_policy) | resource |
| [aws_s3_bucket_policy.codebuild_flow_logs_bucket](https://registry.terraform.io/providers/hashicorp/aws/3.75.2/docs/resources/s3_bucket_policy) | resource |
| [aws_s3_bucket_public_access_block.codebuild_artifact_bucket](https://registry.terraform.io/providers/hashicorp/aws/3.75.2/docs/resources/s3_bucket_public_access_block) | resource |
| [aws_s3_bucket_public_access_block.codebuild_flow_logs_bucket](https://registry.terraform.io/providers/hashicorp/aws/3.75.2/docs/resources/s3_bucket_public_access_block) | resource |
| [aws_s3_bucket_public_access_block.scanning_results_bucket](https://registry.terraform.io/providers/hashicorp/aws/3.75.2/docs/resources/s3_bucket_public_access_block) | resource |
| [aws_security_group.codebuild_vpc_sg](https://registry.terraform.io/providers/hashicorp/aws/3.75.2/docs/resources/security_group) | resource |
| [aws_security_group_rule.allow_all_github_git](https://registry.terraform.io/providers/hashicorp/aws/3.75.2/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.allow_all_github_http](https://registry.terraform.io/providers/hashicorp/aws/3.75.2/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.allow_all_github_ssh](https://registry.terraform.io/providers/hashicorp/aws/3.75.2/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.allow_all_github_ssl](https://registry.terraform.io/providers/hashicorp/aws/3.75.2/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.allow_github_http_ingress](https://registry.terraform.io/providers/hashicorp/aws/3.75.2/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.allow_github_ssl_ingress](https://registry.terraform.io/providers/hashicorp/aws/3.75.2/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.allow_outbound_gpg_server_traffic](https://registry.terraform.io/providers/hashicorp/aws/3.75.2/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.vpc_to_cb_vpce_egress](https://registry.terraform.io/providers/hashicorp/aws/3.75.2/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.vpce_to_cb_vpc_ingress](https://registry.terraform.io/providers/hashicorp/aws/3.75.2/docs/resources/security_group_rule) | resource |
| [aws_sns_topic.build_notifications](https://registry.terraform.io/providers/hashicorp/aws/3.75.2/docs/resources/sns_topic) | resource |
| [aws_sns_topic.scanning_notifications](https://registry.terraform.io/providers/hashicorp/aws/3.75.2/docs/resources/sns_topic) | resource |
| [aws_sns_topic_policy.default](https://registry.terraform.io/providers/hashicorp/aws/3.75.2/docs/resources/sns_topic_policy) | resource |
| [aws_sns_topic_policy.scanning_notifications](https://registry.terraform.io/providers/hashicorp/aws/3.75.2/docs/resources/sns_topic_policy) | resource |
| [aws_sns_topic_subscription.build_notice_subscription](https://registry.terraform.io/providers/hashicorp/aws/3.75.2/docs/resources/sns_topic_subscription) | resource |
| [aws_sns_topic_subscription.scanning_notice_subscription](https://registry.terraform.io/providers/hashicorp/aws/3.75.2/docs/resources/sns_topic_subscription) | resource |
| [aws_ssm_parameter.slack_webhook](https://registry.terraform.io/providers/hashicorp/aws/3.75.2/docs/resources/ssm_parameter) | resource |
| [aws_vpc_endpoint.codepipeline_vpc_endpoint](https://registry.terraform.io/providers/hashicorp/aws/3.75.2/docs/resources/vpc_endpoint) | resource |
| [archive_file.codebuild_notification](https://registry.terraform.io/providers/hashicorp/archive/2.2.0/docs/data-sources/file) | data source |
| [archive_file.scanning_notification](https://registry.terraform.io/providers/hashicorp/archive/2.2.0/docs/data-sources/file) | data source |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/3.75.2/docs/data-sources/caller_identity) | data source |
| [aws_iam_user.ci_user](https://registry.terraform.io/providers/hashicorp/aws/3.75.2/docs/data-sources/iam_user) | data source |
| [aws_region.current](https://registry.terraform.io/providers/hashicorp/aws/3.75.2/docs/data-sources/region) | data source |
| [aws_ssm_parameter.slack_webhook](https://registry.terraform.io/providers/hashicorp/aws/3.75.2/docs/data-sources/ssm_parameter) | data source |
| [template_file.allow_access_to_scanning_results_bucket](https://registry.terraform.io/providers/hashicorp/template/2.2.0/docs/data-sources/file) | data source |
| [template_file.allow_ci_slack_ssm](https://registry.terraform.io/providers/hashicorp/template/2.2.0/docs/data-sources/file) | data source |
| [template_file.allow_codestar_kms](https://registry.terraform.io/providers/hashicorp/template/2.2.0/docs/data-sources/file) | data source |
| [template_file.allow_dynamodb_lock_table_access](https://registry.terraform.io/providers/hashicorp/template/2.2.0/docs/data-sources/file) | data source |
| [template_file.allow_scanning_sns_publish_policy](https://registry.terraform.io/providers/hashicorp/template/2.2.0/docs/data-sources/file) | data source |
| [template_file.allow_sns_publish_policy](https://registry.terraform.io/providers/hashicorp/template/2.2.0/docs/data-sources/file) | data source |
| [template_file.child_accounts_cmk_access_template](https://registry.terraform.io/providers/hashicorp/template/2.2.0/docs/data-sources/file) | data source |
| [template_file.codebuild_bucket_policy](https://registry.terraform.io/providers/hashicorp/template/2.2.0/docs/data-sources/file) | data source |
| [template_file.codebuild_flow_logs_bucket](https://registry.terraform.io/providers/hashicorp/template/2.2.0/docs/data-sources/file) | data source |
| [template_file.scanning_webhook_source](https://registry.terraform.io/providers/hashicorp/template/2.2.0/docs/data-sources/file) | data source |
| [template_file.webhook_source](https://registry.terraform.io/providers/hashicorp/template/2.2.0/docs/data-sources/file) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_allow_accounts"></a> [allow\_accounts](#input\_allow\_accounts) | A list of account ids allowed to access our s3 resource | `list(string)` | n/a | yes |
| <a name="input_aws_logs_bucket"></a> [aws\_logs\_bucket](#input\_aws\_logs\_bucket) | Our account logging bucket for s3 logs | `string` | n/a | yes |
| <a name="input_channel_name"></a> [channel\_name](#input\_channel\_name) | Our slack channel for notifications | `string` | `"moj-cjse-bichard"` | no |
| <a name="input_name"></a> [name](#input\_name) | Our resource name | `string` | n/a | yes |
| <a name="input_notifications_channel_name"></a> [notifications\_channel\_name](#input\_notifications\_channel\_name) | Our slack channel for build notifications | `string` | `"moj-cjse-bichard-notifications"` | no |
| <a name="input_slack_webhook"></a> [slack\_webhook](#input\_slack\_webhook) | Our webhook for slack | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of resource tags | `map(string)` | n/a | yes |
| <a name="input_vpc_cidr_block"></a> [vpc\_cidr\_block](#input\_vpc\_cidr\_block) | Our cidr block to apply to this vpc | `string` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_codebuild_cidr_block"></a> [codebuild\_cidr\_block](#output\_codebuild\_cidr\_block) | Our CIDR block for codebuild |
| <a name="output_codebuild_nat_gateway_ids"></a> [codebuild\_nat\_gateway\_ids](#output\_codebuild\_nat\_gateway\_ids) | The nat gateway ids for our public subnets |
| <a name="output_codebuild_private_cidr_blocks"></a> [codebuild\_private\_cidr\_blocks](#output\_codebuild\_private\_cidr\_blocks) | A list of private cidr blocks |
| <a name="output_codebuild_private_cidrs"></a> [codebuild\_private\_cidrs](#output\_codebuild\_private\_cidrs) | The internal cidrs for our codebuild vpc |
| <a name="output_codebuild_private_subnet_ids"></a> [codebuild\_private\_subnet\_ids](#output\_codebuild\_private\_subnet\_ids) | A list of private subnet ids |
| <a name="output_codebuild_public_cidr_blocks"></a> [codebuild\_public\_cidr\_blocks](#output\_codebuild\_public\_cidr\_blocks) | A list of public cidr blocks |
| <a name="output_codebuild_public_cidrs"></a> [codebuild\_public\_cidrs](#output\_codebuild\_public\_cidrs) | The external cidrs for our codebuild vpc |
| <a name="output_codebuild_public_subnet_ids"></a> [codebuild\_public\_subnet\_ids](#output\_codebuild\_public\_subnet\_ids) | A list of public subnet ids |
| <a name="output_codebuild_security_group_id"></a> [codebuild\_security\_group\_id](#output\_codebuild\_security\_group\_id) | The allowed security group id for our codebuild\_vpc |
| <a name="output_codebuild_subnet_ids"></a> [codebuild\_subnet\_ids](#output\_codebuild\_subnet\_ids) | A list of private subnet ids |
| <a name="output_codebuild_vpc_config_block"></a> [codebuild\_vpc\_config\_block](#output\_codebuild\_vpc\_config\_block) | A preformed config block to pass to codebuild |
| <a name="output_codebuild_vpc_id"></a> [codebuild\_vpc\_id](#output\_codebuild\_vpc\_id) | The vpc id for our codebuild jobs |
| <a name="output_codepipeline_bucket"></a> [codepipeline\_bucket](#output\_codepipeline\_bucket) | The name of our bucket |
| <a name="output_codepipeline_bucket_arn"></a> [codepipeline\_bucket\_arn](#output\_codepipeline\_bucket\_arn) | The arn of our bucket |
| <a name="output_concurrency_dynamo_db_table"></a> [concurrency\_dynamo\_db\_table](#output\_concurrency\_dynamo\_db\_table) | The dynamotable we are going to use for concurrency locks |
| <a name="output_notifications_arn"></a> [notifications\_arn](#output\_notifications\_arn) | The arn of our sns topic |
| <a name="output_notifications_kms_key_arn"></a> [notifications\_kms\_key\_arn](#output\_notifications\_kms\_key\_arn) | The notifications KMS key |
| <a name="output_notifications_slack_webhook_path"></a> [notifications\_slack\_webhook\_path](#output\_notifications\_slack\_webhook\_path) | The ssm path for our slack webhook |
| <a name="output_scanning_notifications_arn"></a> [scanning\_notifications\_arn](#output\_scanning\_notifications\_arn) | The arn of our scanning sns topic |
| <a name="output_scanning_notifications_kms_key_arn"></a> [scanning\_notifications\_kms\_key\_arn](#output\_scanning\_notifications\_kms\_key\_arn) | The scanning notifications KMS key |
| <a name="output_scanning_results_bucket"></a> [scanning\_results\_bucket](#output\_scanning\_results\_bucket) | The name of our scanning results bucket |
<!-- END_TF_DOCS -->
