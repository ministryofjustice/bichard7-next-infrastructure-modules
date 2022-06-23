# Ecs Cluster ALB

Module to bind an alb/nlb with listeners to a cluster

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.13 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | = 3.75.2 |
| <a name="requirement_template"></a> [template](#requirement\_template) | = 2.2.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 3.75.2 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_alb.alb](https://registry.terraform.io/providers/hashicorp/aws/3.75.2/docs/resources/alb) | resource |
| [aws_lb_listener.alb_listener](https://registry.terraform.io/providers/hashicorp/aws/3.75.2/docs/resources/lb_listener) | resource |
| [aws_lb_target_group.alb_target_group](https://registry.terraform.io/providers/hashicorp/aws/3.75.2/docs/resources/lb_target_group) | resource |
| [aws_lb_target_group.sticky_alb_target_group](https://registry.terraform.io/providers/hashicorp/aws/3.75.2/docs/resources/lb_target_group) | resource |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/3.75.2/docs/data-sources/caller_identity) | data source |
| [aws_region.current](https://registry.terraform.io/providers/hashicorp/aws/3.75.2/docs/data-sources/region) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_alb_health_check"></a> [alb\_health\_check](#input\_alb\_health\_check) | A map containing our alb health check | `map(string)` | <pre>{<br>  "healthy_threshold": 10,<br>  "interval": 30,<br>  "protocol": "TCP",<br>  "unhealthy_threshold": 10<br>}</pre> | no |
| <a name="input_alb_is_internal"></a> [alb\_is\_internal](#input\_alb\_is\_internal) | Is our alb internal only, defaults to true | `bool` | `true` | no |
| <a name="input_alb_listener"></a> [alb\_listener](#input\_alb\_listener) | Configuration for our listeners | `any` | n/a | yes |
| <a name="input_alb_name"></a> [alb\_name](#input\_alb\_name) | The name of our alb | `string` | n/a | yes |
| <a name="input_alb_name_prefix"></a> [alb\_name\_prefix](#input\_alb\_name\_prefix) | The name prefix for our alb | `string` | n/a | yes |
| <a name="input_alb_port"></a> [alb\_port](#input\_alb\_port) | The port our alb is listening on | `number` | n/a | yes |
| <a name="input_alb_protocol"></a> [alb\_protocol](#input\_alb\_protocol) | The protocol in use on the alb | `string` | `"TCP"` | no |
| <a name="input_alb_security_groups"></a> [alb\_security\_groups](#input\_alb\_security\_groups) | A list of security group ids for our load balancer only valid for application load balancers | `list(string)` | `null` | no |
| <a name="input_alb_slow_start"></a> [alb\_slow\_start](#input\_alb\_slow\_start) | Do we need a warm up period for our application | `number` | `0` | no |
| <a name="input_alb_target_type"></a> [alb\_target\_type](#input\_alb\_target\_type) | The target type our alb is using | `string` | `"ip"` | no |
| <a name="input_default_action"></a> [default\_action](#input\_default\_action) | A list of list of maps of our default action | `any` | `[]` | no |
| <a name="input_enable_alb_logging"></a> [enable\_alb\_logging](#input\_enable\_alb\_logging) | Do we want to enable alb logging (hint, yes, yes we do) | `bool` | `true` | no |
| <a name="input_idle_timeout"></a> [idle\_timeout](#input\_idle\_timeout) | How long in seconds before we terminate a connection | `number` | `180` | no |
| <a name="input_load_balancer_type"></a> [load\_balancer\_type](#input\_load\_balancer\_type) | The type of load balancer to create. Possible values are application, gateway, or network | `string` | `"application"` | no |
| <a name="input_logging_bucket_name"></a> [logging\_bucket\_name](#input\_logging\_bucket\_name) | The name of our logging bucket to ship our alb access logs to | `string` | n/a | yes |
| <a name="input_redirect_config"></a> [redirect\_config](#input\_redirect\_config) | A list of list of maps of our redirect configuration, order is important as we look this up based on the count index of the module | `any` | <pre>[<br>  []<br>]</pre> | no |
| <a name="input_service_subnets"></a> [service\_subnets](#input\_service\_subnets) | The subnets on which our alb will serve traffic | `list(string)` | n/a | yes |
| <a name="input_stickiness"></a> [stickiness](#input\_stickiness) | A map containing any sticky session settings | `map(string)` | `null` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of tags | `map(string)` | n/a | yes |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | The id of our vpc | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_dns_name"></a> [dns\_name](#output\_dns\_name) | The internal dns name of our alb |
| <a name="output_load_balancer"></a> [load\_balancer](#output\_load\_balancer) | The outputs from our load balancer |
| <a name="output_target_group"></a> [target\_group](#output\_target\_group) | The load balancer target group |
<!-- END_TF_DOCS -->
