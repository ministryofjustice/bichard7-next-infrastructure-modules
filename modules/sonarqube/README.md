# Sonarqube

Module for creating sonarqube cluster on the dev environment

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.13 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | = 3.56.0 |
| <a name="requirement_local"></a> [local](#requirement\_local) | = 2.0.0 |
| <a name="requirement_template"></a> [template](#requirement\_template) | = 2.2.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 3.56.0 |
| <a name="provider_external"></a> [external](#provider\_external) | 2.1.1 |
| <a name="provider_null"></a> [null](#provider\_null) | 3.1.0 |
| <a name="provider_random"></a> [random](#provider\_random) | 3.1.0 |
| <a name="provider_template"></a> [template](#provider\_template) | 2.2.0 |
| <a name="provider_terraform"></a> [terraform](#provider\_terraform) | n/a |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_vpc"></a> [vpc](#module\_vpc) | terraform-aws-modules/vpc/aws | 2.78.0 |

## Resources

| Name | Type |
|------|------|
| [aws_acm_certificate.base_infra_certificate](https://registry.terraform.io/providers/hashicorp/aws/3.56.0/docs/resources/acm_certificate) | resource |
| [aws_acm_certificate_validation.base_infra_certificate_validation](https://registry.terraform.io/providers/hashicorp/aws/3.56.0/docs/resources/acm_certificate_validation) | resource |
| [aws_alb.sonar_alb](https://registry.terraform.io/providers/hashicorp/aws/3.56.0/docs/resources/alb) | resource |
| [aws_cloudwatch_log_group.sonar_log_group](https://registry.terraform.io/providers/hashicorp/aws/3.56.0/docs/resources/cloudwatch_log_group) | resource |
| [aws_cloudwatch_log_stream.sonar_log_stream](https://registry.terraform.io/providers/hashicorp/aws/3.56.0/docs/resources/cloudwatch_log_stream) | resource |
| [aws_db_instance.sonar_db](https://registry.terraform.io/providers/hashicorp/aws/3.56.0/docs/resources/db_instance) | resource |
| [aws_ecs_cluster.sonarqube_cluster](https://registry.terraform.io/providers/hashicorp/aws/3.56.0/docs/resources/ecs_cluster) | resource |
| [aws_ecs_service.sonar_service](https://registry.terraform.io/providers/hashicorp/aws/3.56.0/docs/resources/ecs_service) | resource |
| [aws_ecs_task_definition.sonar_tasks](https://registry.terraform.io/providers/hashicorp/aws/3.56.0/docs/resources/ecs_task_definition) | resource |
| [aws_iam_policy.sonarqube_allow_ecr_access](https://registry.terraform.io/providers/hashicorp/aws/3.56.0/docs/resources/iam_policy) | resource |
| [aws_iam_role.sonarqube_task_role](https://registry.terraform.io/providers/hashicorp/aws/3.56.0/docs/resources/iam_role) | resource |
| [aws_iam_role_policy.allow_ssm](https://registry.terraform.io/providers/hashicorp/aws/3.56.0/docs/resources/iam_role_policy) | resource |
| [aws_iam_role_policy_attachment.attach_ecs_code_deploy_role_for_ecs](https://registry.terraform.io/providers/hashicorp/aws/3.56.0/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.attach_ecs_task_execution](https://registry.terraform.io/providers/hashicorp/aws/3.56.0/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.sonarqube_allow_ecr_attachment](https://registry.terraform.io/providers/hashicorp/aws/3.56.0/docs/resources/iam_role_policy_attachment) | resource |
| [aws_kms_alias.cloudwatch_kms_alias](https://registry.terraform.io/providers/hashicorp/aws/3.56.0/docs/resources/kms_alias) | resource |
| [aws_kms_key.cloudwatch_encryption](https://registry.terraform.io/providers/hashicorp/aws/3.56.0/docs/resources/kms_key) | resource |
| [aws_lb_listener.sonar_http_listener](https://registry.terraform.io/providers/hashicorp/aws/3.56.0/docs/resources/lb_listener) | resource |
| [aws_lb_listener.sonar_https_listener](https://registry.terraform.io/providers/hashicorp/aws/3.56.0/docs/resources/lb_listener) | resource |
| [aws_lb_target_group.sonar_alb](https://registry.terraform.io/providers/hashicorp/aws/3.56.0/docs/resources/lb_target_group) | resource |
| [aws_route53_record.base_infra_public_zone_validation_records](https://registry.terraform.io/providers/hashicorp/aws/3.56.0/docs/resources/route53_record) | resource |
| [aws_route53_record.db_entry](https://registry.terraform.io/providers/hashicorp/aws/3.56.0/docs/resources/route53_record) | resource |
| [aws_route53_record.parent_zone_validation_records](https://registry.terraform.io/providers/hashicorp/aws/3.56.0/docs/resources/route53_record) | resource |
| [aws_route53_record.sonar_record](https://registry.terraform.io/providers/hashicorp/aws/3.56.0/docs/resources/route53_record) | resource |
| [aws_security_group.sonar_alb](https://registry.terraform.io/providers/hashicorp/aws/3.56.0/docs/resources/security_group) | resource |
| [aws_security_group.sonar_github_git_traffic](https://registry.terraform.io/providers/hashicorp/aws/3.56.0/docs/resources/security_group) | resource |
| [aws_security_group.sonar_github_ssh_traffic](https://registry.terraform.io/providers/hashicorp/aws/3.56.0/docs/resources/security_group) | resource |
| [aws_security_group.sonar_github_web_traffic](https://registry.terraform.io/providers/hashicorp/aws/3.56.0/docs/resources/security_group) | resource |
| [aws_security_group.sonar_security_group](https://registry.terraform.io/providers/hashicorp/aws/3.56.0/docs/resources/security_group) | resource |
| [aws_security_group_rule.allow_alb_to_container](https://registry.terraform.io/providers/hashicorp/aws/3.56.0/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.allow_all_github_git](https://registry.terraform.io/providers/hashicorp/aws/3.56.0/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.allow_all_github_http](https://registry.terraform.io/providers/hashicorp/aws/3.56.0/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.allow_all_github_ssh](https://registry.terraform.io/providers/hashicorp/aws/3.56.0/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.allow_all_github_ssl](https://registry.terraform.io/providers/hashicorp/aws/3.56.0/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.allow_http_egress](https://registry.terraform.io/providers/hashicorp/aws/3.56.0/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.allow_http_ingress](https://registry.terraform.io/providers/hashicorp/aws/3.56.0/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.allow_https_egress](https://registry.terraform.io/providers/hashicorp/aws/3.56.0/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.allow_https_ingress](https://registry.terraform.io/providers/hashicorp/aws/3.56.0/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.postgres_db_egress](https://registry.terraform.io/providers/hashicorp/aws/3.56.0/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.postgres_db_ingress](https://registry.terraform.io/providers/hashicorp/aws/3.56.0/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.sonar_egress](https://registry.terraform.io/providers/hashicorp/aws/3.56.0/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.sonar_ingress](https://registry.terraform.io/providers/hashicorp/aws/3.56.0/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.sonar_to_postgres_egress](https://registry.terraform.io/providers/hashicorp/aws/3.56.0/docs/resources/security_group_rule) | resource |
| [aws_ssm_parameter.sonar_admin_user_login](https://registry.terraform.io/providers/hashicorp/aws/3.56.0/docs/resources/ssm_parameter) | resource |
| [aws_ssm_parameter.sonar_admin_user_password](https://registry.terraform.io/providers/hashicorp/aws/3.56.0/docs/resources/ssm_parameter) | resource |
| [aws_ssm_parameter.sonar_db_password](https://registry.terraform.io/providers/hashicorp/aws/3.56.0/docs/resources/ssm_parameter) | resource |
| [aws_ssm_parameter.sonar_db_user](https://registry.terraform.io/providers/hashicorp/aws/3.56.0/docs/resources/ssm_parameter) | resource |
| [null_resource.update_default_username](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) | resource |
| [null_resource.update_password_for_admin_user](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) | resource |
| [random_id.sonar_user_suffix](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/id) | resource |
| [random_password.sonar_admin_user_password](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/password) | resource |
| [random_password.sonar_db_password](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/password) | resource |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/3.56.0/docs/data-sources/caller_identity) | data source |
| [aws_ecr_repository.sonarqube_ecr_repository](https://registry.terraform.io/providers/hashicorp/aws/3.56.0/docs/data-sources/ecr_repository) | data source |
| [aws_region.current](https://registry.terraform.io/providers/hashicorp/aws/3.56.0/docs/data-sources/region) | data source |
| [external_external.latest_sonar_image](https://registry.terraform.io/providers/hashicorp/external/latest/docs/data-sources/external) | data source |
| [template_file.allow_ecr_policy](https://registry.terraform.io/providers/hashicorp/template/2.2.0/docs/data-sources/file) | data source |
| [template_file.sonarqube_ecs_task](https://registry.terraform.io/providers/hashicorp/template/2.2.0/docs/data-sources/file) | data source |
| [terraform_remote_state.account_resources](https://registry.terraform.io/providers/hashicorp/terraform/latest/docs/data-sources/remote_state) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_environment"></a> [environment](#input\_environment) | The target environment, will map to the terraform workspace | `string` | n/a | yes |
| <a name="input_fargate_cpu"></a> [fargate\_cpu](#input\_fargate\_cpu) | The number of cpu units | `number` | `1024` | no |
| <a name="input_fargate_memory"></a> [fargate\_memory](#input\_fargate\_memory) | The amount of memory that will be given to fargate in Megabytes | `number` | `2048` | no |
| <a name="input_logging_bucket_name"></a> [logging\_bucket\_name](#input\_logging\_bucket\_name) | The default logging bucket for lb access logs | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | The deployments name | `string` | n/a | yes |
| <a name="input_server_certificate_arn"></a> [server\_certificate\_arn](#input\_server\_certificate\_arn) | The arn of our server certificate | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of environment tags | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_security_group_ids"></a> [security\_group\_ids](#output\_security\_group\_ids) | A map of security group ids so we can add extra rules |
| <a name="output_sonar_friendly_dns_name"></a> [sonar\_friendly\_dns\_name](#output\_sonar\_friendly\_dns\_name) | The dns name of our sonar deploy |
<!-- END_TF_DOCS -->
