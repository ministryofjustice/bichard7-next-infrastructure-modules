# Codebuild Monitoring Cluster

Provisions a monitoring cluster with the following components

- Grafana

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.13 |
| <a name="requirement_archive"></a> [archive](#requirement\_archive) | = 2.2.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | = 3.75.2 |
| <a name="requirement_grafana"></a> [grafana](#requirement\_grafana) | 1.19.0 |
| <a name="requirement_local"></a> [local](#requirement\_local) | = 2.0.0 |
| <a name="requirement_template"></a> [template](#requirement\_template) | = 2.2.0 |
| <a name="requirement_time"></a> [time](#requirement\_time) | 0.7.2 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_archive"></a> [archive](#provider\_archive) | 2.2.0 |
| <a name="provider_aws"></a> [aws](#provider\_aws) | 3.75.2 |
| <a name="provider_grafana"></a> [grafana](#provider\_grafana) | 1.19.0 |
| <a name="provider_random"></a> [random](#provider\_random) | 3.3.2 |
| <a name="provider_template"></a> [template](#provider\_template) | 2.2.0 |
| <a name="provider_time"></a> [time](#provider\_time) | 0.7.2 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_codebuild_monitoring_ecs_alb"></a> [codebuild\_monitoring\_ecs\_alb](#module\_codebuild\_monitoring\_ecs\_alb) | github.com/ministryofjustice/bichard7-next-infrastructure-modules.git//modules/ecs_cluster_alb | n/a |
| <a name="module_codebuild_monitoring_ecs_cluster"></a> [codebuild\_monitoring\_ecs\_cluster](#module\_codebuild\_monitoring\_ecs\_cluster) | github.com/ministryofjustice/bichard7-next-infrastructure-modules.git//modules/ecs_cluster | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_cloudwatch_event_rule.codebuild_metrics_lambda](https://registry.terraform.io/providers/hashicorp/aws/3.75.2/docs/resources/cloudwatch_event_rule) | resource |
| [aws_cloudwatch_event_target.codebuild_metrics_lambda](https://registry.terraform.io/providers/hashicorp/aws/3.75.2/docs/resources/cloudwatch_event_target) | resource |
| [aws_cloudwatch_log_group.codebuild_monitoring](https://registry.terraform.io/providers/hashicorp/aws/3.75.2/docs/resources/cloudwatch_log_group) | resource |
| [aws_db_subnet_group.grafana_subnet_group](https://registry.terraform.io/providers/hashicorp/aws/3.75.2/docs/resources/db_subnet_group) | resource |
| [aws_iam_role.codebuild_metrics_lambda](https://registry.terraform.io/providers/hashicorp/aws/3.75.2/docs/resources/iam_role) | resource |
| [aws_iam_role_policy.allow_ecs_cloudwatch](https://registry.terraform.io/providers/hashicorp/aws/3.75.2/docs/resources/iam_role_policy) | resource |
| [aws_iam_role_policy.codebuild_metrics_lambda](https://registry.terraform.io/providers/hashicorp/aws/3.75.2/docs/resources/iam_role_policy) | resource |
| [aws_kms_alias.aurora_cluster_encryption_key_alias](https://registry.terraform.io/providers/hashicorp/aws/3.75.2/docs/resources/kms_alias) | resource |
| [aws_kms_alias.logging_encryption_key_alias](https://registry.terraform.io/providers/hashicorp/aws/3.75.2/docs/resources/kms_alias) | resource |
| [aws_kms_key.aurora_cluster_encryption_key](https://registry.terraform.io/providers/hashicorp/aws/3.75.2/docs/resources/kms_key) | resource |
| [aws_kms_key.logging_encryption_key](https://registry.terraform.io/providers/hashicorp/aws/3.75.2/docs/resources/kms_key) | resource |
| [aws_lambda_function.codebuild_metrics_lambda](https://registry.terraform.io/providers/hashicorp/aws/3.75.2/docs/resources/lambda_function) | resource |
| [aws_lambda_permission.allow_cloudwatch_to_call_check_foo](https://registry.terraform.io/providers/hashicorp/aws/3.75.2/docs/resources/lambda_permission) | resource |
| [aws_rds_cluster.grafana_db](https://registry.terraform.io/providers/hashicorp/aws/3.75.2/docs/resources/rds_cluster) | resource |
| [aws_rds_cluster_instance.grafana_db_instance](https://registry.terraform.io/providers/hashicorp/aws/3.75.2/docs/resources/rds_cluster_instance) | resource |
| [aws_route53_record.grafana_public_record](https://registry.terraform.io/providers/hashicorp/aws/3.75.2/docs/resources/route53_record) | resource |
| [aws_security_group.grafana_alb_security_group](https://registry.terraform.io/providers/hashicorp/aws/3.75.2/docs/resources/security_group) | resource |
| [aws_security_group.grafana_cluster_security_group](https://registry.terraform.io/providers/hashicorp/aws/3.75.2/docs/resources/security_group) | resource |
| [aws_security_group.grafana_db_security_group](https://registry.terraform.io/providers/hashicorp/aws/3.75.2/docs/resources/security_group) | resource |
| [aws_security_group_rule.allow_db_ingress_from_grafana_containers](https://registry.terraform.io/providers/hashicorp/aws/3.75.2/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.allow_grafana_alb_http_ingress](https://registry.terraform.io/providers/hashicorp/aws/3.75.2/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.allow_grafana_alb_https_egress_to_grafana](https://registry.terraform.io/providers/hashicorp/aws/3.75.2/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.allow_grafana_alb_https_ingress](https://registry.terraform.io/providers/hashicorp/aws/3.75.2/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.allow_grafana_alb_https_ingress_to_grafana](https://registry.terraform.io/providers/hashicorp/aws/3.75.2/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.allow_grafana_container_egress_to_world](https://registry.terraform.io/providers/hashicorp/aws/3.75.2/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.allow_grafana_egress_to_db](https://registry.terraform.io/providers/hashicorp/aws/3.75.2/docs/resources/security_group_rule) | resource |
| [aws_ssm_parameter.admin_password](https://registry.terraform.io/providers/hashicorp/aws/3.75.2/docs/resources/ssm_parameter) | resource |
| [aws_ssm_parameter.grafana_admin_api_key](https://registry.terraform.io/providers/hashicorp/aws/3.75.2/docs/resources/ssm_parameter) | resource |
| [aws_ssm_parameter.grafana_admin_password](https://registry.terraform.io/providers/hashicorp/aws/3.75.2/docs/resources/ssm_parameter) | resource |
| [aws_ssm_parameter.grafana_admin_username](https://registry.terraform.io/providers/hashicorp/aws/3.75.2/docs/resources/ssm_parameter) | resource |
| [aws_ssm_parameter.grafana_db_password](https://registry.terraform.io/providers/hashicorp/aws/3.75.2/docs/resources/ssm_parameter) | resource |
| [aws_ssm_parameter.grafana_db_username](https://registry.terraform.io/providers/hashicorp/aws/3.75.2/docs/resources/ssm_parameter) | resource |
| [aws_ssm_parameter.grafana_secret_key](https://registry.terraform.io/providers/hashicorp/aws/3.75.2/docs/resources/ssm_parameter) | resource |
| [aws_ssm_parameter.readonly_password](https://registry.terraform.io/providers/hashicorp/aws/3.75.2/docs/resources/ssm_parameter) | resource |
| [grafana_api_key.admin_api_key](https://registry.terraform.io/providers/grafana/grafana/1.19.0/docs/resources/api_key) | resource |
| [grafana_dashboard.codebuild_dashboard](https://registry.terraform.io/providers/grafana/grafana/1.19.0/docs/resources/dashboard) | resource |
| [grafana_dashboard.codebuild_ecs_stats](https://registry.terraform.io/providers/grafana/grafana/1.19.0/docs/resources/dashboard) | resource |
| [grafana_dashboard.codebuild_last_build_status_dashboard](https://registry.terraform.io/providers/grafana/grafana/1.19.0/docs/resources/dashboard) | resource |
| [grafana_dashboard.codebuild_status_dashboard](https://registry.terraform.io/providers/grafana/grafana/1.19.0/docs/resources/dashboard) | resource |
| [grafana_data_source.cloudwatch](https://registry.terraform.io/providers/grafana/grafana/1.19.0/docs/resources/data_source) | resource |
| [grafana_user.admin_user](https://registry.terraform.io/providers/grafana/grafana/1.19.0/docs/resources/user) | resource |
| [grafana_user.readonly_user](https://registry.terraform.io/providers/grafana/grafana/1.19.0/docs/resources/user) | resource |
| [random_password.admin_password](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/password) | resource |
| [random_password.grafana_admin_password](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/password) | resource |
| [random_password.grafana_db_password](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/password) | resource |
| [random_password.readonly_password](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/password) | resource |
| [random_string.grafana_admin_suffix](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/string) | resource |
| [random_string.grafana_dbuser](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/string) | resource |
| [random_string.grafana_secret_key](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/string) | resource |
| [time_sleep.wait_for_containers](https://registry.terraform.io/providers/hashicorp/time/0.7.2/docs/resources/sleep) | resource |
| [archive_file.codebuild_metrics_payload](https://registry.terraform.io/providers/hashicorp/archive/2.2.0/docs/data-sources/file) | data source |
| [aws_availability_zones.current](https://registry.terraform.io/providers/hashicorp/aws/3.75.2/docs/data-sources/availability_zones) | data source |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/3.75.2/docs/data-sources/caller_identity) | data source |
| [aws_iam_group.admins](https://registry.terraform.io/providers/hashicorp/aws/3.75.2/docs/data-sources/iam_group) | data source |
| [aws_iam_group.viewers](https://registry.terraform.io/providers/hashicorp/aws/3.75.2/docs/data-sources/iam_group) | data source |
| [aws_region.current](https://registry.terraform.io/providers/hashicorp/aws/3.75.2/docs/data-sources/region) | data source |
| [aws_route53_zone.public_zone](https://registry.terraform.io/providers/hashicorp/aws/3.75.2/docs/data-sources/route53_zone) | data source |
| [template_file.allow_kms_access](https://registry.terraform.io/providers/hashicorp/template/2.2.0/docs/data-sources/file) | data source |
| [template_file.codebuild_metrics_permissions](https://registry.terraform.io/providers/hashicorp/template/2.2.0/docs/data-sources/file) | data source |
| [template_file.grafana_ecs_task](https://registry.terraform.io/providers/hashicorp/template/2.2.0/docs/data-sources/file) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_fargate_cpu"></a> [fargate\_cpu](#input\_fargate\_cpu) | The number of cpu units | `number` | `1024` | no |
| <a name="input_fargate_memory"></a> [fargate\_memory](#input\_fargate\_memory) | The amount of memory that will be given to fargate in Megabytes | `number` | `2048` | no |
| <a name="input_grafana_db_instance_class"></a> [grafana\_db\_instance\_class](#input\_grafana\_db\_instance\_class) | The class of DB instance we are using for Grafana | `string` | `"db.t4g.medium"` | no |
| <a name="input_grafana_db_instance_count"></a> [grafana\_db\_instance\_count](#input\_grafana\_db\_instance\_count) | The number of DB instance we are using for Grafana | `number` | `3` | no |
| <a name="input_grafana_image"></a> [grafana\_image](#input\_grafana\_image) | The url of our grafana ecs image we want to use | `string` | n/a | yes |
| <a name="input_grafana_repository_arn"></a> [grafana\_repository\_arn](#input\_grafana\_repository\_arn) | The arn of our grafana repository | `string` | n/a | yes |
| <a name="input_idle_timeout"></a> [idle\_timeout](#input\_idle\_timeout) | How long in seconds before we terminate a connection | `number` | `180` | no |
| <a name="input_logging_bucket_name"></a> [logging\_bucket\_name](#input\_logging\_bucket\_name) | The default logging bucket for lb access logs | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | The deployments name | `string` | n/a | yes |
| <a name="input_private_subnets"></a> [private\_subnets](#input\_private\_subnets) | The private subnets to deploy our db into | `list(string)` | n/a | yes |
| <a name="input_public_zone_id"></a> [public\_zone\_id](#input\_public\_zone\_id) | The zone id for our public hosted zone so we can use ACM certificates | `string` | n/a | yes |
| <a name="input_remote_exec_enabled"></a> [remote\_exec\_enabled](#input\_remote\_exec\_enabled) | Do we want to allow remote-exec onto these containers | `bool` | `true` | no |
| <a name="input_service_subnets"></a> [service\_subnets](#input\_service\_subnets) | A list of our subnets | `list(string)` | n/a | yes |
| <a name="input_ssl_certificate_arn"></a> [ssl\_certificate\_arn](#input\_ssl\_certificate\_arn) | The arn of our acm certificate | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of environment tags | `map(string)` | `{}` | no |
| <a name="input_using_smtp_service"></a> [using\_smtp\_service](#input\_using\_smtp\_service) | Are we using the CJSM smtp service | `bool` | `false` | no |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | The vpc id for our security groups to bind to | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_grafana_admin_user_name"></a> [grafana\_admin\_user\_name](#output\_grafana\_admin\_user\_name) | The user name of our grafana admin |
| <a name="output_grafana_admin_user_password"></a> [grafana\_admin\_user\_password](#output\_grafana\_admin\_user\_password) | The password of our grafana admin |
| <a name="output_grafana_api_key"></a> [grafana\_api\_key](#output\_grafana\_api\_key) | The api key we can use to provision grafana resources |
| <a name="output_grafana_external_fqdn"></a> [grafana\_external\_fqdn](#output\_grafana\_external\_fqdn) | The public dns record for our grafana server |
<!-- END_TF_DOCS -->
