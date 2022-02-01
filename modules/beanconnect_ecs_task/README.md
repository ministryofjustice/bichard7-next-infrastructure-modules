# Beanconnect ECS Task

Module to configure Beanconnect on ECS
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
| <a name="provider_random"></a> [random](#provider\_random) | 3.0.1 |
| <a name="provider_template"></a> [template](#provider\_template) | 2.2.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_beanconnect_ecs_alb"></a> [beanconnect\_ecs\_alb](#module\_beanconnect\_ecs\_alb) | github.com/ministryofjustice/bichard7-next-infrastructure-modules.git//modules/ecs_cluster_alb | n/a |
| <a name="module_beanconnect_ecs_service"></a> [beanconnect\_ecs\_service](#module\_beanconnect\_ecs\_service) | github.com/ministryofjustice/bichard7-next-infrastructure-modules.git//modules/ecs_cluster | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_route53_record.bc](https://registry.terraform.io/providers/hashicorp/aws/3.72.0/docs/resources/route53_record) | resource |
| [aws_security_group_rule.allow_all_outbound](https://registry.terraform.io/providers/hashicorp/aws/3.72.0/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.allow_nlb_from_vpc](https://registry.terraform.io/providers/hashicorp/aws/3.72.0/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.beanconnect_ingress_from_bichard7](https://registry.terraform.io/providers/hashicorp/aws/3.72.0/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.was_egress_to_beanconnect](https://registry.terraform.io/providers/hashicorp/aws/3.72.0/docs/resources/security_group_rule) | resource |
| [aws_ssm_parameter.beanconnect_deploy_tag](https://registry.terraform.io/providers/hashicorp/aws/3.72.0/docs/resources/ssm_parameter) | resource |
| [aws_ssm_parameter.beanconnect_password](https://registry.terraform.io/providers/hashicorp/aws/3.72.0/docs/resources/ssm_parameter) | resource |
| [random_password.beanconnect](https://registry.terraform.io/providers/hashicorp/random/3.0.1/docs/resources/password) | resource |
| [aws_availability_zones.this](https://registry.terraform.io/providers/hashicorp/aws/3.72.0/docs/data-sources/availability_zones) | data source |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/3.72.0/docs/data-sources/caller_identity) | data source |
| [aws_region.current](https://registry.terraform.io/providers/hashicorp/aws/3.72.0/docs/data-sources/region) | data source |
| [aws_route53_zone.cjse_dot_org](https://registry.terraform.io/providers/hashicorp/aws/3.72.0/docs/data-sources/route53_zone) | data source |
| [aws_security_group.beanconnect](https://registry.terraform.io/providers/hashicorp/aws/3.72.0/docs/data-sources/security_group) | data source |
| [aws_security_group.bichard7](https://registry.terraform.io/providers/hashicorp/aws/3.72.0/docs/data-sources/security_group) | data source |
| [template_file.beanconnect_fargate](https://registry.terraform.io/providers/hashicorp/template/2.2.0/docs/data-sources/file) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_admin_allowed_cidr"></a> [admin\_allowed\_cidr](#input\_admin\_allowed\_cidr) | A list of allowed subnet cidrs to access this resource | `list(string)` | n/a | yes |
| <a name="input_beanconnect_ecs_image_hash"></a> [beanconnect\_ecs\_image\_hash](#input\_beanconnect\_ecs\_image\_hash) | The hash of our beanconnect image | `string` | n/a | yes |
| <a name="input_beanconnect_ecs_image_url"></a> [beanconnect\_ecs\_image\_url](#input\_beanconnect\_ecs\_image\_url) | The url and sha256 hash of our beanconnect image | `string` | n/a | yes |
| <a name="input_beanconnect_log_group"></a> [beanconnect\_log\_group](#input\_beanconnect\_log\_group) | The log group we will be pushing our logs too | `any` | n/a | yes |
| <a name="input_beanconnect_repo_arn"></a> [beanconnect\_repo\_arn](#input\_beanconnect\_repo\_arn) | n/a | `string` | n/a | yes |
| <a name="input_desired_instance_count"></a> [desired\_instance\_count](#input\_desired\_instance\_count) | The number of instances we wish to deploy | `number` | `null` | no |
| <a name="input_fargate_cpu"></a> [fargate\_cpu](#input\_fargate\_cpu) | The number of cpu units | `number` | n/a | yes |
| <a name="input_fargate_memory"></a> [fargate\_memory](#input\_fargate\_memory) | The amount of memory that will be given to fargate in Megabytes | `number` | n/a | yes |
| <a name="input_logging_bucket_name"></a> [logging\_bucket\_name](#input\_logging\_bucket\_name) | The default logging bucket for lb access logs | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | The calling layers name | `string` | n/a | yes |
| <a name="input_parent_account_id"></a> [parent\_account\_id](#input\_parent\_account\_id) | Our Parent Account ID | `string` | n/a | yes |
| <a name="input_pnc_aeq"></a> [pnc\_aeq](#input\_pnc\_aeq) | The application entity qualifier | `string` | `null` | no |
| <a name="input_pnc_contwin"></a> [pnc\_contwin](#input\_pnc\_contwin) | The number of contention winners | `string` | `null` | no |
| <a name="input_pnc_lpap"></a> [pnc\_lpap](#input\_pnc\_lpap) | The name of the PNC LPAP connection | `string` | `null` | no |
| <a name="input_pnc_proxy_hostname"></a> [pnc\_proxy\_hostname](#input\_pnc\_proxy\_hostname) | The proxy hostname for BeanConnect | `string` | `null` | no |
| <a name="input_private_zone_id"></a> [private\_zone\_id](#input\_private\_zone\_id) | The private hosted zone | `string` | n/a | yes |
| <a name="input_service_subnets"></a> [service\_subnets](#input\_service\_subnets) | A list of our subnet ids to attach the tasks onto | `list(string)` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of tags | `map(string)` | `{}` | no |
| <a name="input_using_pnc_emulator"></a> [using\_pnc\_emulator](#input\_using\_pnc\_emulator) | Is this stack using a pnc emulator | `bool` | `false` | no |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | The id of our vpc | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_beanconnect_dns_lb"></a> [beanconnect\_dns\_lb](#output\_beanconnect\_dns\_lb) | DNS entry for load balancer |
| <a name="output_internal_fqdn"></a> [internal\_fqdn](#output\_internal\_fqdn) | The internal FQDN of our db |
| <a name="output_load_balancer_arn"></a> [load\_balancer\_arn](#output\_load\_balancer\_arn) | The load balancer arn for beanconnect |
| <a name="output_pnc_proxy_endpoint_port"></a> [pnc\_proxy\_endpoint\_port](#output\_pnc\_proxy\_endpoint\_port) | The port we are connecting to the pnc proxy on |
| <a name="output_target_group_arn"></a> [target\_group\_arn](#output\_target\_group\_arn) | The target group arn for beanconnect |
<!-- END_TF_DOCS -->
