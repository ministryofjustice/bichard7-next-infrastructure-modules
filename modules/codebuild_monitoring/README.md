# Codebuild Monitoring Cluster

Provisions a monitoring cluster with the following components
- Grafana

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
| <a name="provider_random"></a> [random](#provider\_random) | 3.1.0 |
| <a name="provider_template"></a> [template](#provider\_template) | 2.2.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_codebuild_monitoring_ecs_alb"></a> [codebuild\_monitoring\_ecs\_alb](#module\_codebuild\_monitoring\_ecs\_alb) | ../ecs_cluster_alb | n/a |
| <a name="module_codebuild_monitoring_ecs_cluster"></a> [codebuild\_monitoring\_ecs\_cluster](#module\_codebuild\_monitoring\_ecs\_cluster) | ../ecs_cluster | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_cloudwatch_log_group.codebuild_monitoring](https://registry.terraform.io/providers/hashicorp/aws/3.72.0/docs/resources/cloudwatch_log_group) | resource |
| [aws_db_subnet_group.grafana_subnet_group](https://registry.terraform.io/providers/hashicorp/aws/3.72.0/docs/resources/db_subnet_group) | resource |
| [aws_ecs_cluster.monitoring_cluster](https://registry.terraform.io/providers/hashicorp/aws/3.72.0/docs/resources/ecs_cluster) | resource |
| [aws_kms_alias.aurora_cluster_encryption_key_alias](https://registry.terraform.io/providers/hashicorp/aws/3.72.0/docs/resources/kms_alias) | resource |
| [aws_kms_alias.cluster_logs_encryption_key](https://registry.terraform.io/providers/hashicorp/aws/3.72.0/docs/resources/kms_alias) | resource |
| [aws_kms_alias.logging_encryption_key_alias](https://registry.terraform.io/providers/hashicorp/aws/3.72.0/docs/resources/kms_alias) | resource |
| [aws_kms_key.aurora_cluster_encryption_key](https://registry.terraform.io/providers/hashicorp/aws/3.72.0/docs/resources/kms_key) | resource |
| [aws_kms_key.cluster_logs_encryption_key](https://registry.terraform.io/providers/hashicorp/aws/3.72.0/docs/resources/kms_key) | resource |
| [aws_kms_key.logging_encryption_key](https://registry.terraform.io/providers/hashicorp/aws/3.72.0/docs/resources/kms_key) | resource |
| [aws_rds_cluster.grafana_db](https://registry.terraform.io/providers/hashicorp/aws/3.72.0/docs/resources/rds_cluster) | resource |
| [aws_rds_cluster_instance.grafana_db_instance](https://registry.terraform.io/providers/hashicorp/aws/3.72.0/docs/resources/rds_cluster_instance) | resource |
| [aws_security_group.grafana_cluster_security_group](https://registry.terraform.io/providers/hashicorp/aws/3.72.0/docs/resources/security_group) | resource |
| [aws_security_group.grafana_db_security_group](https://registry.terraform.io/providers/hashicorp/aws/3.72.0/docs/resources/security_group) | resource |
| [aws_ssm_parameter.grafana_admin_password](https://registry.terraform.io/providers/hashicorp/aws/3.72.0/docs/resources/ssm_parameter) | resource |
| [aws_ssm_parameter.grafana_admin_username](https://registry.terraform.io/providers/hashicorp/aws/3.72.0/docs/resources/ssm_parameter) | resource |
| [aws_ssm_parameter.grafana_db_password](https://registry.terraform.io/providers/hashicorp/aws/3.72.0/docs/resources/ssm_parameter) | resource |
| [aws_ssm_parameter.grafana_db_username](https://registry.terraform.io/providers/hashicorp/aws/3.72.0/docs/resources/ssm_parameter) | resource |
| [aws_ssm_parameter.grafana_secret_key](https://registry.terraform.io/providers/hashicorp/aws/3.72.0/docs/resources/ssm_parameter) | resource |
| [random_password.grafana_admin_password](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/password) | resource |
| [random_password.grafana_db_password](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/password) | resource |
| [random_string.grafana_admin_suffix](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/string) | resource |
| [random_string.grafana_dbuser](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/string) | resource |
| [random_string.grafana_secret_key](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/string) | resource |
| [aws_availability_zones.current](https://registry.terraform.io/providers/hashicorp/aws/3.72.0/docs/data-sources/availability_zones) | data source |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/3.72.0/docs/data-sources/caller_identity) | data source |
| [aws_region.current](https://registry.terraform.io/providers/hashicorp/aws/3.72.0/docs/data-sources/region) | data source |
| [aws_route53_zone.public_zone](https://registry.terraform.io/providers/hashicorp/aws/3.72.0/docs/data-sources/route53_zone) | data source |
| [template_file.allow_cmk_admin_access](https://registry.terraform.io/providers/hashicorp/template/2.2.0/docs/data-sources/file) | data source |
| [template_file.allow_ecr_policy](https://registry.terraform.io/providers/hashicorp/template/2.2.0/docs/data-sources/file) | data source |
| [template_file.allow_kms_access](https://registry.terraform.io/providers/hashicorp/template/2.2.0/docs/data-sources/file) | data source |
| [template_file.allow_ssm](https://registry.terraform.io/providers/hashicorp/template/2.2.0/docs/data-sources/file) | data source |
| [template_file.allow_ssm_messages](https://registry.terraform.io/providers/hashicorp/template/2.2.0/docs/data-sources/file) | data source |
| [template_file.grafana_ecs_task](https://registry.terraform.io/providers/hashicorp/template/2.2.0/docs/data-sources/file) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_fargate_cpu"></a> [fargate\_cpu](#input\_fargate\_cpu) | The number of cpu units | `number` | `1024` | no |
| <a name="input_fargate_memory"></a> [fargate\_memory](#input\_fargate\_memory) | The amount of memory that will be given to fargate in Megabytes | `number` | `2048` | no |
| <a name="input_grafana_db_instance_class"></a> [grafana\_db\_instance\_class](#input\_grafana\_db\_instance\_class) | The class of DB instance we are using for Grafana | `string` | `"db.t3.medium"` | no |
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

No outputs.
<!-- END_TF_DOCS -->
