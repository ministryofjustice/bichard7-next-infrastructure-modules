# Nginx Auth Proxy ECS

Provisions and configures the nginx auth proxy ECS task. Currently this has a seperate configuration for the alb as we
are presenting both http and https.
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

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_nginx_auth_proxy_ecs"></a> [nginx\_auth\_proxy\_ecs](#module\_nginx\_auth\_proxy\_ecs) | github.com/ministryofjustice/bichard7-next-infrastructure-modules.git//modules/ecs_cluster | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_alb.auth_proxy_alb](https://registry.terraform.io/providers/hashicorp/aws/3.75.2/docs/resources/alb) | resource |
| [aws_lb_listener.alb_listener_http](https://registry.terraform.io/providers/hashicorp/aws/3.75.2/docs/resources/lb_listener) | resource |
| [aws_lb_listener.alb_listener_https](https://registry.terraform.io/providers/hashicorp/aws/3.75.2/docs/resources/lb_listener) | resource |
| [aws_lb_target_group.alb_target_group_http](https://registry.terraform.io/providers/hashicorp/aws/3.75.2/docs/resources/lb_target_group) | resource |
| [aws_lb_target_group.alb_target_group_https](https://registry.terraform.io/providers/hashicorp/aws/3.75.2/docs/resources/lb_target_group) | resource |
| [aws_route53_record.nginx_auth_proxy](https://registry.terraform.io/providers/hashicorp/aws/3.75.2/docs/resources/route53_record) | resource |
| [aws_security_group_rule.allow_alb_http_to_containers](https://registry.terraform.io/providers/hashicorp/aws/3.75.2/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.allow_alb_https_to_containers](https://registry.terraform.io/providers/hashicorp/aws/3.75.2/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.allow_all_outbound_http](https://registry.terraform.io/providers/hashicorp/aws/3.75.2/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.allow_all_outbound_https](https://registry.terraform.io/providers/hashicorp/aws/3.75.2/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.allow_audit_logging_http_alb_ingress_from_auth_proxy](https://registry.terraform.io/providers/hashicorp/aws/3.75.2/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.allow_audit_logging_http_egress_to_auth_proxy](https://registry.terraform.io/providers/hashicorp/aws/3.75.2/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.allow_audit_logging_https_alb_ingress_from_auth_proxy](https://registry.terraform.io/providers/hashicorp/aws/3.75.2/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.allow_audit_logging_https_egress_to_auth_proxy](https://registry.terraform.io/providers/hashicorp/aws/3.75.2/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.allow_bichard_backend_http_alb_ingress_from_auth_proxy](https://registry.terraform.io/providers/hashicorp/aws/3.75.2/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.allow_bichard_backend_https_alb_ingress_from_auth_proxy](https://registry.terraform.io/providers/hashicorp/aws/3.75.2/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.allow_bichard_http_alb_ingress_from_auth_proxy](https://registry.terraform.io/providers/hashicorp/aws/3.75.2/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.allow_bichard_https_alb_ingress_from_auth_proxy](https://registry.terraform.io/providers/hashicorp/aws/3.75.2/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.allow_bichard_https_egress_to_auth_proxy](https://registry.terraform.io/providers/hashicorp/aws/3.75.2/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.allow_containers_all_outbound](https://registry.terraform.io/providers/hashicorp/aws/3.75.2/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.allow_http_from_alb_to_containers](https://registry.terraform.io/providers/hashicorp/aws/3.75.2/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.allow_http_to_alb_from_vpc](https://registry.terraform.io/providers/hashicorp/aws/3.75.2/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.allow_https_from_alb_to_containers](https://registry.terraform.io/providers/hashicorp/aws/3.75.2/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.allow_https_to_alb_from_vpc](https://registry.terraform.io/providers/hashicorp/aws/3.75.2/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.allow_ui_http_alb_ingress_from_auth_proxy](https://registry.terraform.io/providers/hashicorp/aws/3.75.2/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.allow_ui_http_egress_to_auth_proxy](https://registry.terraform.io/providers/hashicorp/aws/3.75.2/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.allow_ui_https_alb_ingress_from_auth_proxy](https://registry.terraform.io/providers/hashicorp/aws/3.75.2/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.allow_ui_https_egress_to_auth_proxy](https://registry.terraform.io/providers/hashicorp/aws/3.75.2/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.allow_user_service_http_alb_ingress_from_auth_proxy](https://registry.terraform.io/providers/hashicorp/aws/3.75.2/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.allow_user_service_http_egress_to_auth_proxy](https://registry.terraform.io/providers/hashicorp/aws/3.75.2/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.allow_user_service_https_alb_ingress_from_auth_proxy](https://registry.terraform.io/providers/hashicorp/aws/3.75.2/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.allow_user_service_https_egress_to_auth_proxy](https://registry.terraform.io/providers/hashicorp/aws/3.75.2/docs/resources/security_group_rule) | resource |
| [aws_ssm_parameter.nginx_auth_proxy_deploy_tag](https://registry.terraform.io/providers/hashicorp/aws/3.75.2/docs/resources/ssm_parameter) | resource |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/3.75.2/docs/data-sources/caller_identity) | data source |
| [aws_region.current](https://registry.terraform.io/providers/hashicorp/aws/3.75.2/docs/data-sources/region) | data source |
| [aws_route53_zone.public_zone](https://registry.terraform.io/providers/hashicorp/aws/3.75.2/docs/data-sources/route53_zone) | data source |
| [aws_security_group.audit_logging_portal_alb](https://registry.terraform.io/providers/hashicorp/aws/3.75.2/docs/data-sources/security_group) | data source |
| [aws_security_group.bichard_alb](https://registry.terraform.io/providers/hashicorp/aws/3.75.2/docs/data-sources/security_group) | data source |
| [aws_security_group.bichard_backend_alb](https://registry.terraform.io/providers/hashicorp/aws/3.75.2/docs/data-sources/security_group) | data source |
| [aws_security_group.nginx_auth_proxy_alb](https://registry.terraform.io/providers/hashicorp/aws/3.75.2/docs/data-sources/security_group) | data source |
| [aws_security_group.nginx_auth_proxy_ecs](https://registry.terraform.io/providers/hashicorp/aws/3.75.2/docs/data-sources/security_group) | data source |
| [aws_security_group.ui_alb](https://registry.terraform.io/providers/hashicorp/aws/3.75.2/docs/data-sources/security_group) | data source |
| [aws_security_group.user_service_alb](https://registry.terraform.io/providers/hashicorp/aws/3.75.2/docs/data-sources/security_group) | data source |
| [template_file.nginx_auth_proxy_fargate](https://registry.terraform.io/providers/hashicorp/template/2.2.0/docs/data-sources/file) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_admin_allowed_cidr"></a> [admin\_allowed\_cidr](#input\_admin\_allowed\_cidr) | A list of subnet CIDRs allowed to access this resource | `list(string)` | n/a | yes |
| <a name="input_desired_instance_count"></a> [desired\_instance\_count](#input\_desired\_instance\_count) | How many containers do we want to deploy | `number` | `1` | no |
| <a name="input_dns_resolver"></a> [dns\_resolver](#input\_dns\_resolver) | The dns resolver hostname for nginx | `string` | n/a | yes |
| <a name="input_fargate_cpu"></a> [fargate\_cpu](#input\_fargate\_cpu) | The number of CPU units | `number` | n/a | yes |
| <a name="input_fargate_memory"></a> [fargate\_memory](#input\_fargate\_memory) | The amount of memory that will be given to fargate in Megabytes | `number` | n/a | yes |
| <a name="input_logging_bucket_name"></a> [logging\_bucket\_name](#input\_logging\_bucket\_name) | The default logging bucket for lb access logs | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | The calling layers name | `string` | n/a | yes |
| <a name="input_nginx_auth_proxy_ecs_arn"></a> [nginx\_auth\_proxy\_ecs\_arn](#input\_nginx\_auth\_proxy\_ecs\_arn) | The arn of our NGINX auth | `string` | n/a | yes |
| <a name="input_nginx_auth_proxy_ecs_image_hash"></a> [nginx\_auth\_proxy\_ecs\_image\_hash](#input\_nginx\_auth\_proxy\_ecs\_image\_hash) | The hash of our deployable image | `string` | n/a | yes |
| <a name="input_nginx_auth_proxy_ecs_image_url"></a> [nginx\_auth\_proxy\_ecs\_image\_url](#input\_nginx\_auth\_proxy\_ecs\_image\_url) | Our image URL to deploy | `string` | n/a | yes |
| <a name="input_nginx_auth_proxy_log_group"></a> [nginx\_auth\_proxy\_log\_group](#input\_nginx\_auth\_proxy\_log\_group) | The log group we will be pushing our logs to | `any` | n/a | yes |
| <a name="input_override_deploy_tags"></a> [override\_deploy\_tags](#input\_override\_deploy\_tags) | Required for CI/CD, do we want to allow us to overwrite the deploy tag | `bool` | `false` | no |
| <a name="input_public_zone_id"></a> [public\_zone\_id](#input\_public\_zone\_id) | The zone id for our public hosted zone so we can use ACM certificates | `string` | n/a | yes |
| <a name="input_service_subnets"></a> [service\_subnets](#input\_service\_subnets) | A list of our subnet ids to attach the tasks onto | `list(string)` | n/a | yes |
| <a name="input_ssl_certificate_arn"></a> [ssl\_certificate\_arn](#input\_ssl\_certificate\_arn) | The arn of our ssl certificate | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of tags | `map(string)` | `{}` | no |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | The id of our vpc | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_external_fqdn"></a> [external\_fqdn](#output\_external\_fqdn) | The external FQDN of the NGINX auth proxy |
| <a name="output_http_target_group_arn"></a> [http\_target\_group\_arn](#output\_http\_target\_group\_arn) | The arn of the http target group |
| <a name="output_https_target_group_arn"></a> [https\_target\_group\_arn](#output\_https\_target\_group\_arn) | The arn of the http target group |
| <a name="output_load_balancer_arn"></a> [load\_balancer\_arn](#output\_load\_balancer\_arn) | The arn of the load balancer |
| <a name="output_nginx_auth_proxy_dns_lb"></a> [nginx\_auth\_proxy\_dns\_lb](#output\_nginx\_auth\_proxy\_dns\_lb) | DNS entry for NGINX auth proxy load balancer |
<!-- END_TF_DOCS -->
