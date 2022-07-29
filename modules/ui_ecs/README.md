<!-- BEGIN_TF_DOCS -->

## Requirements

| Name                                                                     | Version  |
| ------------------------------------------------------------------------ | -------- |
| <a name="requirement_terraform"></a> [terraform](#requirement_terraform) | >= 0.13  |
| <a name="requirement_aws"></a> [aws](#requirement_aws)                   | = 3.75.2 |
| <a name="requirement_local"></a> [local](#requirement_local)             | = 2.0.0  |
| <a name="requirement_template"></a> [template](#requirement_template)    | = 2.2.0  |

## Providers

| Name                                                            | Version |
| --------------------------------------------------------------- | ------- |
| <a name="provider_aws"></a> [aws](#provider_aws)                | 3.75.2  |
| <a name="provider_template"></a> [template](#provider_template) | 2.2.0   |

## Modules

| Name                                                  | Source                                                                                         | Version |
| ----------------------------------------------------- | ---------------------------------------------------------------------------------------------- | ------- |
| <a name="module_ui_alb"></a> [ui_alb](#module_ui_alb) | github.com/ministryofjustice/bichard7-next-infrastructure-modules.git//modules/ecs_cluster_alb | n/a     |
| <a name="module_ui_ecs"></a> [ui_ecs](#module_ui_ecs) | github.com/ministryofjustice/bichard7-next-infrastructure-modules.git//modules/ecs_cluster     | n/a     |

## Resources

| Name                                                                                                                                                            | Type        |
| --------------------------------------------------------------------------------------------------------------------------------------------------------------- | ----------- |
| [aws_route53_record.ui](https://registry.terraform.io/providers/hashicorp/aws/3.75.2/docs/resources/route53_record)                                             | resource    |
| [aws_security_group_rule.allow_alb_to_containers](https://registry.terraform.io/providers/hashicorp/aws/3.75.2/docs/resources/security_group_rule)              | resource    |
| [aws_security_group_rule.allow_containers_s3_outbound](https://registry.terraform.io/providers/hashicorp/aws/3.75.2/docs/resources/security_group_rule)         | resource    |
| [aws_security_group_rule.allow_ecs_to_alb](https://registry.terraform.io/providers/hashicorp/aws/3.75.2/docs/resources/security_group_rule)                     | resource    |
| [aws_security_group_rule.allow_https_from_alb_into_containers](https://registry.terraform.io/providers/hashicorp/aws/3.75.2/docs/resources/security_group_rule) | resource    |
| [aws_security_group_rule.allow_https_from_ecs_into_alb](https://registry.terraform.io/providers/hashicorp/aws/3.75.2/docs/resources/security_group_rule)        | resource    |
| [aws_ssm_parameter.ui_deploy_tag](https://registry.terraform.io/providers/hashicorp/aws/3.75.2/docs/resources/ssm_parameter)                                    | resource    |
| [aws_ec2_managed_prefix_list.s3](https://registry.terraform.io/providers/hashicorp/aws/3.75.2/docs/data-sources/ec2_managed_prefix_list)                        | data source |
| [aws_region.current](https://registry.terraform.io/providers/hashicorp/aws/3.75.2/docs/data-sources/region)                                                     | data source |
| [aws_route53_zone.public_zone](https://registry.terraform.io/providers/hashicorp/aws/3.75.2/docs/data-sources/route53_zone)                                     | data source |
| [aws_security_group.ui_alb](https://registry.terraform.io/providers/hashicorp/aws/3.75.2/docs/data-sources/security_group)                                      | data source |
| [aws_security_group.ui_ecs](https://registry.terraform.io/providers/hashicorp/aws/3.75.2/docs/data-sources/security_group)                                      | data source |
| [template_file.ui_fargate](https://registry.terraform.io/providers/hashicorp/template/2.2.0/docs/data-sources/file)                                             | data source |

## Inputs

| Name                                                                                                | Description                                                            | Type           | Default | Required |
| --------------------------------------------------------------------------------------------------- | ---------------------------------------------------------------------- | -------------- | ------- | :------: |
| <a name="input_admin_allowed_cidr"></a> [admin_allowed_cidr](#input_admin_allowed_cidr)             | A list of subnet CIDRs allowed to access this resource                 | `list(string)` | n/a     |   yes    |
| <a name="input_db_host"></a> [db_host](#input_db_host)                                              | Our db endpoint url or fqdn                                            | `string`       | n/a     |   yes    |
| <a name="input_db_password_arn"></a> [db_password_arn](#input_db_password_arn)                      | The arn of our password parameter                                      | `string`       | n/a     |   yes    |
| <a name="input_db_ssl"></a> [db_ssl](#input_db_ssl)                                                 | Are we forcing an ssl connection to postgres                           | `bool`         | `false` |    no    |
| <a name="input_desired_instance_count"></a> [desired_instance_count](#input_desired_instance_count) | The number of containers we wish to provision                          | `number`       | `1`     |    no    |
| <a name="input_fargate_cpu"></a> [fargate_cpu](#input_fargate_cpu)                                  | The number of CPU units                                                | `number`       | n/a     |   yes    |
| <a name="input_fargate_memory"></a> [fargate_memory](#input_fargate_memory)                         | The amount of memory that will be given to fargate in Megabytes        | `number`       | n/a     |   yes    |
| <a name="input_logging_bucket_name"></a> [logging_bucket_name](#input_logging_bucket_name)          | The default logging bucket for lb access logs                          | `string`       | n/a     |   yes    |
| <a name="input_name"></a> [name](#input_name)                                                       | The calling layers name                                                | `string`       | n/a     |   yes    |
| <a name="input_override_deploy_tags"></a> [override_deploy_tags](#input_override_deploy_tags)       | Required for CI/CD, do we want to allow us to overwrite the deploy tag | `bool`         | `false` |    no    |
| <a name="input_public_zone_id"></a> [public_zone_id](#input_public_zone_id)                         | The zone id for our public hosted zone so we can use ACM certificates  | `string`       | n/a     |   yes    |
| <a name="input_service_subnets"></a> [service_subnets](#input_service_subnets)                      | A list of our subnet ids to attach the tasks onto                      | `list(string)` | n/a     |   yes    |
| <a name="input_ssl_certificate_arn"></a> [ssl_certificate_arn](#input_ssl_certificate_arn)          | The arn of our ssl certificate                                         | `string`       | n/a     |   yes    |
| <a name="input_tags"></a> [tags](#input_tags)                                                       | A map of tags                                                          | `map(string)`  | `{}`    |    no    |
| <a name="input_ui_ecs_arn"></a> [ui_ecs_arn](#input_ui_ecs_arn)                                     | The arn of our ui                                                      | `string`       | n/a     |   yes    |
| <a name="input_ui_ecs_image_hash"></a> [ui_ecs_image_hash](#input_ui_ecs_image_hash)                | The hash of our deployable image                                       | `string`       | n/a     |   yes    |
| <a name="input_ui_ecs_image_url"></a> [ui_ecs_image_url](#input_ui_ecs_image_url)                   | Our image URL to deploy                                                | `string`       | n/a     |   yes    |
| <a name="input_ui_log_group"></a> [ui_log_group](#input_ui_log_group)                               | The log group we will be pushing our logs to                           | `any`          | n/a     |   yes    |
| <a name="input_vpc_id"></a> [vpc_id](#input_vpc_id)                                                 | The id of our vpc                                                      | `string`       | n/a     |   yes    |

## Outputs

| Name                                                                                | Description                     |
| ----------------------------------------------------------------------------------- | ------------------------------- |
| <a name="output_external_fqdn"></a> [external_fqdn](#output_external_fqdn)          | The external FQDN of the ui     |
| <a name="output_lb_arn"></a> [lb_arn](#output_lb_arn)                               | The arn of our ui load balancer |
| <a name="output_target_group_arn"></a> [target_group_arn](#output_target_group_arn) | The arn of our iu target group  |
| <a name="output_ui_dns_lb"></a> [ui_dns_lb](#output_ui_dns_lb)                      | DNS entry for ui load balancer  |

<!-- END_TF_DOCS -->
