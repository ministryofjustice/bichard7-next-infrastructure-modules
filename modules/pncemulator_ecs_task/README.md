# PNCEmulator ECS Task

Module to configure the pnc emulator on ECS
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
| <a name="module_pncemulator_ecs_alb"></a> [pncemulator\_ecs\_alb](#module\_pncemulator\_ecs\_alb) | github.com/ministryofjustice/bichard7-next-infrastructure-modules.git//modules/ecs_cluster_alb | n/a |
| <a name="module_pncemulator_ecs_service"></a> [pncemulator\_ecs\_service](#module\_pncemulator\_ecs\_service) | github.com/ministryofjustice/bichard7-next-infrastructure-modules.git//modules/ecs_cluster | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_lb_listener.pncemulator_api_listener](https://registry.terraform.io/providers/hashicorp/aws/3.72.0/docs/resources/lb_listener) | resource |
| [aws_lb_target_group.pncemulator_api](https://registry.terraform.io/providers/hashicorp/aws/3.72.0/docs/resources/lb_target_group) | resource |
| [aws_security_group_rule.allow_all_outbound](https://registry.terraform.io/providers/hashicorp/aws/3.72.0/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.nlb_api_ingress_from_vpc](https://registry.terraform.io/providers/hashicorp/aws/3.72.0/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.nlb_utm_ingress_from_vpc](https://registry.terraform.io/providers/hashicorp/aws/3.72.0/docs/resources/security_group_rule) | resource |
| [aws_availability_zones.this](https://registry.terraform.io/providers/hashicorp/aws/3.72.0/docs/data-sources/availability_zones) | data source |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/3.72.0/docs/data-sources/caller_identity) | data source |
| [aws_region.current](https://registry.terraform.io/providers/hashicorp/aws/3.72.0/docs/data-sources/region) | data source |
| [aws_security_group.pncemulator](https://registry.terraform.io/providers/hashicorp/aws/3.72.0/docs/data-sources/security_group) | data source |
| [template_file.pncemulator_fargate](https://registry.terraform.io/providers/hashicorp/template/2.2.0/docs/data-sources/file) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_admin_allowed_cidr"></a> [admin\_allowed\_cidr](#input\_admin\_allowed\_cidr) | A list of allowed subnet cidrs to access this resource | `list(string)` | n/a | yes |
| <a name="input_desired_instance_count"></a> [desired\_instance\_count](#input\_desired\_instance\_count) | The number of instances we wish to deploy | `number` | `null` | no |
| <a name="input_fargate_cpu"></a> [fargate\_cpu](#input\_fargate\_cpu) | The number of cpu units | `number` | n/a | yes |
| <a name="input_fargate_memory"></a> [fargate\_memory](#input\_fargate\_memory) | The amount of memory that will be given to fargate in Megabytes | `number` | n/a | yes |
| <a name="input_logging_bucket_name"></a> [logging\_bucket\_name](#input\_logging\_bucket\_name) | The default logging bucket for lb access logs | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | The calling layers name | `string` | n/a | yes |
| <a name="input_parent_account_id"></a> [parent\_account\_id](#input\_parent\_account\_id) | Our Parent Account ID | `string` | n/a | yes |
| <a name="input_pncemulator_ecs_image_url"></a> [pncemulator\_ecs\_image\_url](#input\_pncemulator\_ecs\_image\_url) | The url and sha256 hash of our pncemulator image | `string` | n/a | yes |
| <a name="input_pncemulator_log_group"></a> [pncemulator\_log\_group](#input\_pncemulator\_log\_group) | The log group for our pnc emulator | `any` | n/a | yes |
| <a name="input_pncemulator_repo_arn"></a> [pncemulator\_repo\_arn](#input\_pncemulator\_repo\_arn) | The arn of the pnc emulator | `string` | n/a | yes |
| <a name="input_service_subnets"></a> [service\_subnets](#input\_service\_subnets) | A list of our subnet ids to attach the tasks onto | `list(string)` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of tags | `map(string)` | `{}` | no |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | The id of our vpc | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_pncemulator_dns_lb"></a> [pncemulator\_dns\_lb](#output\_pncemulator\_dns\_lb) | DNS entry for load balancer |
<!-- END_TF_DOCS -->
