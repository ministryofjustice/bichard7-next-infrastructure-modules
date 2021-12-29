# Audit Logging ECS

Configures audit logging portal service on ECS

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.13 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | = 3.56.0 |
| <a name="requirement_local"></a> [local](#requirement\_local) | = 2.0.0 |
| <a name="requirement_random"></a> [random](#requirement\_random) | = 3.0.1 |
| <a name="requirement_template"></a> [template](#requirement\_template) | = 2.2.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 3.56.0 |
| <a name="provider_template"></a> [template](#provider\_template) | 2.2.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_audit_logging_portal_ecs_alb"></a> [audit\_logging\_portal\_ecs\_alb](#module\_audit\_logging\_portal\_ecs\_alb) | github.com/ministryofjustice/bichard7-next-infrastructure-modules.git//modules/ecs_cluster_alb | n/a |
| <a name="module_audit_logging_portal_service"></a> [audit\_logging\_portal\_service](#module\_audit\_logging\_portal\_service) | github.com/ministryofjustice/bichard7-next-infrastructure-modules.git//modules/ecs_cluster | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_route53_record.audit_logging](https://registry.terraform.io/providers/hashicorp/aws/3.56.0/docs/resources/route53_record) | resource |
| [aws_security_group_rule.allow_alb_to_containers](https://registry.terraform.io/providers/hashicorp/aws/3.56.0/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.allow_all_outbound_http](https://registry.terraform.io/providers/hashicorp/aws/3.56.0/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.allow_all_outbound_https](https://registry.terraform.io/providers/hashicorp/aws/3.56.0/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.allow_containers_all_outbound](https://registry.terraform.io/providers/hashicorp/aws/3.56.0/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.allow_http_from_alb_to_containers](https://registry.terraform.io/providers/hashicorp/aws/3.56.0/docs/resources/security_group_rule) | resource |
| [aws_ssm_parameter.audit_logging_deploy_tag](https://registry.terraform.io/providers/hashicorp/aws/3.56.0/docs/resources/ssm_parameter) | resource |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/3.56.0/docs/data-sources/caller_identity) | data source |
| [aws_region.current](https://registry.terraform.io/providers/hashicorp/aws/3.56.0/docs/data-sources/region) | data source |
| [aws_route53_zone.public_zone](https://registry.terraform.io/providers/hashicorp/aws/3.56.0/docs/data-sources/route53_zone) | data source |
| [aws_security_group.audit_logging_portal](https://registry.terraform.io/providers/hashicorp/aws/3.56.0/docs/data-sources/security_group) | data source |
| [aws_security_group.audit_logging_portal_alb](https://registry.terraform.io/providers/hashicorp/aws/3.56.0/docs/data-sources/security_group) | data source |
| [template_file.audit_logging_portal_fargate](https://registry.terraform.io/providers/hashicorp/template/2.2.0/docs/data-sources/file) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_admin_allowed_cidr"></a> [admin\_allowed\_cidr](#input\_admin\_allowed\_cidr) | A list of allowed subnet cidrs to access this resource | `list(string)` | n/a | yes |
| <a name="input_api_url"></a> [api\_url](#input\_api\_url) | The url of our api lambda function | `string` | n/a | yes |
| <a name="input_audit_log_api_key_arn"></a> [audit\_log\_api\_key\_arn](#input\_audit\_log\_api\_key\_arn) | The SSM ARN for the API key used to access the audit log API | `string` | n/a | yes |
| <a name="input_audit_logging_portal_ecs_arn"></a> [audit\_logging\_portal\_ecs\_arn](#input\_audit\_logging\_portal\_ecs\_arn) | The arn of our audit logging portal | `string` | n/a | yes |
| <a name="input_audit_logging_portal_ecs_image_hash"></a> [audit\_logging\_portal\_ecs\_image\_hash](#input\_audit\_logging\_portal\_ecs\_image\_hash) | Our image hash to deploy | `string` | n/a | yes |
| <a name="input_audit_logging_portal_ecs_image_url"></a> [audit\_logging\_portal\_ecs\_image\_url](#input\_audit\_logging\_portal\_ecs\_image\_url) | Our image url to deploy | `string` | n/a | yes |
| <a name="input_audit_logging_portal_log_group"></a> [audit\_logging\_portal\_log\_group](#input\_audit\_logging\_portal\_log\_group) | The log group we will be pushing our logs too | `any` | n/a | yes |
| <a name="input_desired_instance_count"></a> [desired\_instance\_count](#input\_desired\_instance\_count) | The number of containers we wish to provision | `number` | `1` | no |
| <a name="input_fargate_cpu"></a> [fargate\_cpu](#input\_fargate\_cpu) | The number of cpu units | `number` | n/a | yes |
| <a name="input_fargate_memory"></a> [fargate\_memory](#input\_fargate\_memory) | The amount of memory that will be given to fargate in Megabytes | `number` | n/a | yes |
| <a name="input_logging_bucket_name"></a> [logging\_bucket\_name](#input\_logging\_bucket\_name) | The default logging bucket for lb access logs | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | The calling layers name | `string` | n/a | yes |
| <a name="input_override_deploy_tags"></a> [override\_deploy\_tags](#input\_override\_deploy\_tags) | Required for CI/CD, do we want to allow us to overwrite the deploy tag | `bool` | `false` | no |
| <a name="input_public_zone_id"></a> [public\_zone\_id](#input\_public\_zone\_id) | The zone id for our public hosted zone so we can use ACM certificates | `string` | n/a | yes |
| <a name="input_service_subnets"></a> [service\_subnets](#input\_service\_subnets) | A list of our subnet ids to attach the tasks onto | `list(string)` | n/a | yes |
| <a name="input_ssl_certificate_arn"></a> [ssl\_certificate\_arn](#input\_ssl\_certificate\_arn) | The arn of our ssl certificate | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of tags | `map(string)` | `{}` | no |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | The id of our vpc | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_audit_logging_portal_dns_lb"></a> [audit\_logging\_portal\_dns\_lb](#output\_audit\_logging\_portal\_dns\_lb) | DNS entry for load balancer |
| <a name="output_external_fqdn"></a> [external\_fqdn](#output\_external\_fqdn) | The external FQDN of our db |
| <a name="output_load_balancer_arn"></a> [load\_balancer\_arn](#output\_load\_balancer\_arn) | The load balancer arn for the audit logging cluster |
| <a name="output_target_group_arn"></a> [target\_group\_arn](#output\_target\_group\_arn) | The target group arn for the audit logging cluster |
<!-- END_TF_DOCS -->
