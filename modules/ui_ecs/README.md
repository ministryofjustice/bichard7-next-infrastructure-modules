<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.13 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | = 3.75.2 |
| <a name="requirement_local"></a> [local](#requirement\_local) | = 2.0.0 |
| <a name="requirement_template"></a> [template](#requirement\_template) | = 2.2.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 3.75.2 |
| <a name="provider_template"></a> [template](#provider\_template) | 2.2.0 |
| <a name="provider_terraform"></a> [terraform](#provider\_terraform) | n/a |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_ui_alb"></a> [ui\_alb](#module\_ui\_alb) | github.com/ministryofjustice/bichard7-next-infrastructure-modules.git//modules/ecs_cluster_alb | n/a |
| <a name="module_ui_ecs"></a> [ui\_ecs](#module\_ui\_ecs) | github.com/ministryofjustice/bichard7-next-infrastructure-modules.git//modules/ecs_cluster | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_route53_record.ui](https://registry.terraform.io/providers/hashicorp/aws/3.75.2/docs/resources/route53_record) | resource |
| [aws_security_group_rule.allow_alb_to_containers](https://registry.terraform.io/providers/hashicorp/aws/3.75.2/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.allow_containers_s3_outbound](https://registry.terraform.io/providers/hashicorp/aws/3.75.2/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.allow_ecs_to_alb](https://registry.terraform.io/providers/hashicorp/aws/3.75.2/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.allow_egress_to_db](https://registry.terraform.io/providers/hashicorp/aws/3.75.2/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.allow_https_from_alb_into_containers](https://registry.terraform.io/providers/hashicorp/aws/3.75.2/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.allow_https_from_ecs_into_alb](https://registry.terraform.io/providers/hashicorp/aws/3.75.2/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.vpc_endpoints_from_es_egress](https://registry.terraform.io/providers/hashicorp/aws/3.75.2/docs/resources/security_group_rule) | resource |
| [aws_ssm_parameter.ui_deploy_tag](https://registry.terraform.io/providers/hashicorp/aws/3.75.2/docs/resources/ssm_parameter) | resource |
| [aws_ec2_managed_prefix_list.s3](https://registry.terraform.io/providers/hashicorp/aws/3.75.2/docs/data-sources/ec2_managed_prefix_list) | data source |
| [aws_region.current](https://registry.terraform.io/providers/hashicorp/aws/3.75.2/docs/data-sources/region) | data source |
| [aws_route53_zone.public_zone](https://registry.terraform.io/providers/hashicorp/aws/3.75.2/docs/data-sources/route53_zone) | data source |
| [aws_security_group.bichard_aurora](https://registry.terraform.io/providers/hashicorp/aws/3.75.2/docs/data-sources/security_group) | data source |
| [aws_security_group.ui_alb](https://registry.terraform.io/providers/hashicorp/aws/3.75.2/docs/data-sources/security_group) | data source |
| [aws_security_group.ui_ecs](https://registry.terraform.io/providers/hashicorp/aws/3.75.2/docs/data-sources/security_group) | data source |
| [template_file.ui_fargate](https://registry.terraform.io/providers/hashicorp/template/2.2.0/docs/data-sources/file) | data source |
| [terraform_remote_state.base_infra](https://registry.terraform.io/providers/hashicorp/terraform/latest/docs/data-sources/remote_state) | data source |
| [terraform_remote_state.data_storage](https://registry.terraform.io/providers/hashicorp/terraform/latest/docs/data-sources/remote_state) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_account"></a> [account](#input\_account) | an account name for our accounts map | `string` | `"sandbox_a"` | no |
| <a name="input_accounts"></a> [accounts](#input\_accounts) | A list of account ids we can assume roles into | `map(string)` | <pre>{<br>  "integration_baseline": "439237763202",<br>  "integration_next": "581823340673",<br>  "production": "415925668545",<br>  "q_solution": "071486367987",<br>  "sandbox_a": "454061736096",<br>  "sandbox_b": "108839434327",<br>  "sandbox_c": "744728743481"<br>}</pre> | no |
| <a name="input_admin_allowed_cidr"></a> [admin\_allowed\_cidr](#input\_admin\_allowed\_cidr) | A list of subnet CIDRs allowed to access this resource | `list(string)` | n/a | yes |
| <a name="input_db_host"></a> [db\_host](#input\_db\_host) | Our db endpoint url or fqdn | `string` | n/a | yes |
| <a name="input_db_password_arn"></a> [db\_password\_arn](#input\_db\_password\_arn) | The arn of our db password parameter | `string` | n/a | yes |
| <a name="input_db_ssl"></a> [db\_ssl](#input\_db\_ssl) | Are we forcing an ssl connection to postgres | `bool` | `false` | no |
| <a name="input_desired_instance_count"></a> [desired\_instance\_count](#input\_desired\_instance\_count) | The number of containers we wish to provision | `number` | `1` | no |
| <a name="input_fargate_cpu"></a> [fargate\_cpu](#input\_fargate\_cpu) | The number of CPU units | `number` | n/a | yes |
| <a name="input_fargate_memory"></a> [fargate\_memory](#input\_fargate\_memory) | The amount of memory that will be given to fargate in Megabytes | `number` | n/a | yes |
| <a name="input_logging_bucket_name"></a> [logging\_bucket\_name](#input\_logging\_bucket\_name) | The default logging bucket for lb access logs | `string` | n/a | yes |
| <a name="input_mq_password_arn"></a> [mq\_password\_arn](#input\_mq\_password\_arn) | The arn of our mq password parameter | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | The calling layers name | `string` | n/a | yes |
| <a name="input_override_deploy_tags"></a> [override\_deploy\_tags](#input\_override\_deploy\_tags) | Required for CI/CD, do we want to allow us to overwrite the deploy tag | `bool` | `false` | no |
| <a name="input_path_to_live_accounts"></a> [path\_to\_live\_accounts](#input\_path\_to\_live\_accounts) | A list of our path to live accounts | `list(string)` | <pre>[<br>  "439237763202",<br>  "581823340673",<br>  "071486367987",<br>  "415925668545"<br>]</pre> | no |
| <a name="input_public_zone_id"></a> [public\_zone\_id](#input\_public\_zone\_id) | The zone id for our public hosted zone so we can use ACM certificates | `string` | n/a | yes |
| <a name="input_service_subnets"></a> [service\_subnets](#input\_service\_subnets) | A list of our subnet ids to attach the tasks onto | `list(string)` | n/a | yes |
| <a name="input_ssl_certificate_arn"></a> [ssl\_certificate\_arn](#input\_ssl\_certificate\_arn) | The arn of our ssl certificate | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of tags | `map(string)` | `{}` | no |
| <a name="input_ui_ecs_arn"></a> [ui\_ecs\_arn](#input\_ui\_ecs\_arn) | The arn of our ui | `string` | n/a | yes |
| <a name="input_ui_ecs_image_hash"></a> [ui\_ecs\_image\_hash](#input\_ui\_ecs\_image\_hash) | The hash of our deployable image | `string` | n/a | yes |
| <a name="input_ui_ecs_image_url"></a> [ui\_ecs\_image\_url](#input\_ui\_ecs\_image\_url) | Our image URL to deploy | `string` | n/a | yes |
| <a name="input_ui_log_group"></a> [ui\_log\_group](#input\_ui\_log\_group) | The log group we will be pushing our logs to | `any` | n/a | yes |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | The id of our vpc | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_external_fqdn"></a> [external\_fqdn](#output\_external\_fqdn) | The external FQDN of the ui |
| <a name="output_lb_arn"></a> [lb\_arn](#output\_lb\_arn) | The arn of our ui load balancer |
| <a name="output_target_group_arn"></a> [target\_group\_arn](#output\_target\_group\_arn) | The arn of our iu target group |
| <a name="output_ui_dns_lb"></a> [ui\_dns\_lb](#output\_ui\_dns\_lb) | DNS entry for ui load balancer |
<!-- END_TF_DOCS -->
