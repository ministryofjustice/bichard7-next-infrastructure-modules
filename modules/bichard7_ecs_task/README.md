# Bichard7 ECS Task

Module to configure Bichard7 on ECS, can be configured to be a web facing or backend container

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.13 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | = 3.72.0 |
| <a name="requirement_local"></a> [local](#requirement\_local) | = 2.0.0 |
| <a name="requirement_random"></a> [random](#requirement\_random) | = 3.0.1 |
| <a name="requirement_template"></a> [template](#requirement\_template) | = 2.2.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 3.72.0 |
| <a name="provider_template"></a> [template](#provider\_template) | 2.2.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_bichard_ecs_alb"></a> [bichard\_ecs\_alb](#module\_bichard\_ecs\_alb) | github.com/ministryofjustice/bichard7-next-infrastructure-modules.git//modules/ecs_cluster_alb | n/a |
| <a name="module_bichard_ecs_service"></a> [bichard\_ecs\_service](#module\_bichard\_ecs\_service) | github.com/ministryofjustice/bichard7-next-infrastructure-modules.git//modules/ecs_cluster | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_route53_record.bichard7](https://registry.terraform.io/providers/hashicorp/aws/3.72.0/docs/resources/route53_record) | resource |
| [aws_route53_record.bichard_public_record](https://registry.terraform.io/providers/hashicorp/aws/3.72.0/docs/resources/route53_record) | resource |
| [aws_security_group_rule.alb_allow_egress_to_instance](https://registry.terraform.io/providers/hashicorp/aws/3.72.0/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.alb_default_https_access_from_alb](https://registry.terraform.io/providers/hashicorp/aws/3.72.0/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.allow_all_outbound](https://registry.terraform.io/providers/hashicorp/aws/3.72.0/docs/resources/security_group_rule) | resource |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/3.72.0/docs/data-sources/caller_identity) | data source |
| [aws_route53_zone.cjse_dot_org](https://registry.terraform.io/providers/hashicorp/aws/3.72.0/docs/data-sources/route53_zone) | data source |
| [aws_security_group.bichard](https://registry.terraform.io/providers/hashicorp/aws/3.72.0/docs/data-sources/security_group) | data source |
| [aws_security_group.bichard_alb](https://registry.terraform.io/providers/hashicorp/aws/3.72.0/docs/data-sources/security_group) | data source |
| [template_file.allow_ecr](https://registry.terraform.io/providers/hashicorp/template/2.2.0/docs/data-sources/file) | data source |
| [template_file.allow_kms](https://registry.terraform.io/providers/hashicorp/template/2.2.0/docs/data-sources/file) | data source |
| [template_file.allow_ssm](https://registry.terraform.io/providers/hashicorp/template/2.2.0/docs/data-sources/file) | data source |
| [template_file.bichard_fargate](https://registry.terraform.io/providers/hashicorp/template/2.2.0/docs/data-sources/file) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_admin_allowed_cidr"></a> [admin\_allowed\_cidr](#input\_admin\_allowed\_cidr) | A list of allowed subnet cidrs to access this resource | `list(string)` | n/a | yes |
| <a name="input_audit_api_key_arn"></a> [audit\_api\_key\_arn](#input\_audit\_api\_key\_arn) | The API key to use for the audit log API | `string` | n/a | yes |
| <a name="input_audit_api_url"></a> [audit\_api\_url](#input\_audit\_api\_url) | The API url to use for the audit log API | `string` | n/a | yes |
| <a name="input_bichard7_log_group"></a> [bichard7\_log\_group](#input\_bichard7\_log\_group) | Our Application log group | `any` | n/a | yes |
| <a name="input_bichard_ecr_repository"></a> [bichard\_ecr\_repository](#input\_bichard\_ecr\_repository) | The url of the ECR repository | `any` | n/a | yes |
| <a name="input_bichard_image_tag"></a> [bichard\_image\_tag](#input\_bichard\_image\_tag) | The sha256 image hash | `string` | n/a | yes |
| <a name="input_cluster_kms_key_arn"></a> [cluster\_kms\_key\_arn](#input\_cluster\_kms\_key\_arn) | The kms key arn created in our base\_ecs module | `string` | n/a | yes |
| <a name="input_cluster_name"></a> [cluster\_name](#input\_cluster\_name) | The nmae of the cluster as created by base\_infra | `string` | n/a | yes |
| <a name="input_db_host"></a> [db\_host](#input\_db\_host) | Our db endpoint url or fqdn | `string` | n/a | yes |
| <a name="input_db_password_arn"></a> [db\_password\_arn](#input\_db\_password\_arn) | The arn of our password parameter | `string` | n/a | yes |
| <a name="input_db_ssl"></a> [db\_ssl](#input\_db\_ssl) | Are we forcing an ssl connection to postgres | `bool` | `false` | no |
| <a name="input_db_ssl_mode"></a> [db\_ssl\_mode](#input\_db\_ssl\_mode) | Do we need to skip certificate checking | `string` | `""` | no |
| <a name="input_desired_instance_count"></a> [desired\_instance\_count](#input\_desired\_instance\_count) | The number of containers we require to be provisioned in the cluster | `number` | n/a | yes |
| <a name="input_fargate_cpu"></a> [fargate\_cpu](#input\_fargate\_cpu) | The number of cpu units | `number` | n/a | yes |
| <a name="input_fargate_memory"></a> [fargate\_memory](#input\_fargate\_memory) | The amount of memory that will be given to fargate in Megabytes | `number` | n/a | yes |
| <a name="input_health_check_tac"></a> [health\_check\_tac](#input\_health\_check\_tac) | The UTM TAC to use for the health check | `string` | n/a | yes |
| <a name="input_jwt_secret_arn"></a> [jwt\_secret\_arn](#input\_jwt\_secret\_arn) | The secret to use for JWT validation | `string` | n/a | yes |
| <a name="input_log_level"></a> [log\_level](#input\_log\_level) | The log level to be used for Bichard running in OpenLiberty | `string` | `"WARN"` | no |
| <a name="input_logging_bucket_name"></a> [logging\_bucket\_name](#input\_logging\_bucket\_name) | The default logging bucket for lb access logs | `string` | n/a | yes |
| <a name="input_mq_conn_str"></a> [mq\_conn\_str](#input\_mq\_conn\_str) | The connection string for the messaging server | `string` | n/a | yes |
| <a name="input_mq_password_arn"></a> [mq\_password\_arn](#input\_mq\_password\_arn) | The arn of the password for the messaging server | `string` | `null` | no |
| <a name="input_mq_user"></a> [mq\_user](#input\_mq\_user) | The user for auth to the messaging server | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | The calling layers name | `string` | n/a | yes |
| <a name="input_private_zone_id"></a> [private\_zone\_id](#input\_private\_zone\_id) | The private hosted zone | `string` | n/a | yes |
| <a name="input_public_zone_id"></a> [public\_zone\_id](#input\_public\_zone\_id) | The zone id for our public hosted zone so we can use ACM certificates | `string` | n/a | yes |
| <a name="input_public_zone_name"></a> [public\_zone\_name](#input\_public\_zone\_name) | The zone name fqdn so we can create a public route53 entry | `string` | n/a | yes |
| <a name="input_service_subnets"></a> [service\_subnets](#input\_service\_subnets) | A list of our subnet ids to attach the tasks onto | `list(string)` | n/a | yes |
| <a name="input_service_type"></a> [service\_type](#input\_service\_type) | What type of service this is (web\|backend) | `string` | n/a | yes |
| <a name="input_ssl_certificate_arn"></a> [ssl\_certificate\_arn](#input\_ssl\_certificate\_arn) | The arn of our ssl certificate | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of tags | `map(string)` | `{}` | no |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | The id of our vpc | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_bichard7_dns_lb"></a> [bichard7\_dns\_lb](#output\_bichard7\_dns\_lb) | DNS entry for load balancer |
| <a name="output_bichard7_public_lb_dns"></a> [bichard7\_public\_lb\_dns](#output\_bichard7\_public\_lb\_dns) | The public dns entry for the alb |
| <a name="output_internal_fqdn"></a> [internal\_fqdn](#output\_internal\_fqdn) | The internal FQDN of our db |
| <a name="output_load_balancer_arn"></a> [load\_balancer\_arn](#output\_load\_balancer\_arn) | The arn of our load balancer for bichard7 app |
| <a name="output_target_group_arn"></a> [target\_group\_arn](#output\_target\_group\_arn) | The arn of our target group for bichard7 app |
<!-- END_TF_DOCS -->
