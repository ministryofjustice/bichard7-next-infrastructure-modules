# Aurora

Opionated Postgres based Aurora DB Cluster


<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.13 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | = 3.75.2 |
| <a name="requirement_random"></a> [random](#requirement\_random) | = 3.0.1 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 3.72.0 |
| <a name="provider_random"></a> [random](#provider\_random) | 3.0.1 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_db_subnet_group.aurora_subnet_group](https://registry.terraform.io/providers/hashicorp/aws/3.75.2/docs/resources/db_subnet_group) | resource |
| [aws_kms_alias.aurora_cluster_encryption_key_alias](https://registry.terraform.io/providers/hashicorp/aws/3.75.2/docs/resources/kms_alias) | resource |
| [aws_kms_key.aurora_cluster_encryption_key](https://registry.terraform.io/providers/hashicorp/aws/3.75.2/docs/resources/kms_key) | resource |
| [aws_rds_cluster.aurora_cluster](https://registry.terraform.io/providers/hashicorp/aws/3.75.2/docs/resources/rds_cluster) | resource |
| [aws_rds_cluster_instance.aurora_cluster_instance](https://registry.terraform.io/providers/hashicorp/aws/3.75.2/docs/resources/rds_cluster_instance) | resource |
| [aws_rds_cluster_parameter_group.default](https://registry.terraform.io/providers/hashicorp/aws/3.75.2/docs/resources/rds_cluster_parameter_group) | resource |
| [aws_route53_record.db](https://registry.terraform.io/providers/hashicorp/aws/3.75.2/docs/resources/route53_record) | resource |
| [aws_route53_record.db_ro](https://registry.terraform.io/providers/hashicorp/aws/3.75.2/docs/resources/route53_record) | resource |
| [aws_security_group_rule.db_egress_to_user_service_ecs](https://registry.terraform.io/providers/hashicorp/aws/3.75.2/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.db_egress_to_was_backend](https://registry.terraform.io/providers/hashicorp/aws/3.75.2/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.db_egress_to_was_web](https://registry.terraform.io/providers/hashicorp/aws/3.75.2/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.user_service_ecs_ingress_to_db](https://registry.terraform.io/providers/hashicorp/aws/3.75.2/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.was_backend_ingress_to_db](https://registry.terraform.io/providers/hashicorp/aws/3.75.2/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.was_web_ingress_to_db](https://registry.terraform.io/providers/hashicorp/aws/3.75.2/docs/resources/security_group_rule) | resource |
| [aws_ssm_parameter.db_password](https://registry.terraform.io/providers/hashicorp/aws/3.75.2/docs/resources/ssm_parameter) | resource |
| [random_password.db](https://registry.terraform.io/providers/hashicorp/random/3.0.1/docs/resources/password) | resource |
| [random_uuid.db_snapshot_id](https://registry.terraform.io/providers/hashicorp/random/3.0.1/docs/resources/uuid) | resource |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/3.75.2/docs/data-sources/caller_identity) | data source |
| [aws_route53_zone.cjse_dot_org](https://registry.terraform.io/providers/hashicorp/aws/3.75.2/docs/data-sources/route53_zone) | data source |
| [aws_security_group.bichard7_backend](https://registry.terraform.io/providers/hashicorp/aws/3.75.2/docs/data-sources/security_group) | data source |
| [aws_security_group.bichard7_web](https://registry.terraform.io/providers/hashicorp/aws/3.75.2/docs/data-sources/security_group) | data source |
| [aws_security_group.db](https://registry.terraform.io/providers/hashicorp/aws/3.75.2/docs/data-sources/security_group) | data source |
| [aws_security_group.user_service_ecs](https://registry.terraform.io/providers/hashicorp/aws/3.75.2/docs/data-sources/security_group) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_db_instance_class"></a> [db\_instance\_class](#input\_db\_instance\_class) | What instances do we want to deploy for our db cluster | `string` | `"db.t3.medium"` | no |
| <a name="input_environment_name"></a> [environment\_name](#input\_environment\_name) | The name of the environment | `string` | n/a | yes |
| <a name="input_private_subnet_ids"></a> [private\_subnet\_ids](#input\_private\_subnet\_ids) | The ID's of the VPC subnets that the RDS cluster instances will be created in | `list(string)` | n/a | yes |
| <a name="input_private_zone_id"></a> [private\_zone\_id](#input\_private\_zone\_id) | The private hosted zone | `string` | n/a | yes |
| <a name="input_rds_database_name"></a> [rds\_database\_name](#input\_rds\_database\_name) | The name of the database | `string` | n/a | yes |
| <a name="input_rds_engine"></a> [rds\_engine](#input\_rds\_engine) | The aurora database engine to use | `string` | n/a | yes |
| <a name="input_rds_engine_version"></a> [rds\_engine\_version](#input\_rds\_engine\_version) | The aurora database engine version to use | `string` | n/a | yes |
| <a name="input_rds_master_username"></a> [rds\_master\_username](#input\_rds\_master\_username) | The master username for the rds instance | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | The tags for the resources | `map(string)` | n/a | yes |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | The ID of the VPC that the RDS cluster will be created in | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_cluster_endpoint"></a> [cluster\_endpoint](#output\_cluster\_endpoint) | The cluster endpoint url |
| <a name="output_cluster_readonly_endpoint"></a> [cluster\_readonly\_endpoint](#output\_cluster\_readonly\_endpoint) | The readonly endpoint for the cluster |
| <a name="output_internal_fqdn"></a> [internal\_fqdn](#output\_internal\_fqdn) | The internal FQDN of our db |
| <a name="output_internal_readonly_fqdn"></a> [internal\_readonly\_fqdn](#output\_internal\_readonly\_fqdn) | The internal readonly FQDN of our db |
| <a name="output_password_arn"></a> [password\_arn](#output\_password\_arn) | The ARN for the password in SSM |
<!-- END_TF_DOCS -->
