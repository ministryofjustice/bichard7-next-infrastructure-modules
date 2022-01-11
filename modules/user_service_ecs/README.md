# User Service ECS

Provisions and configures the user service ECS task
<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.13 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | = 3.56.0 |
| <a name="requirement_local"></a> [local](#requirement\_local) | = 2.0.0 |
| <a name="requirement_template"></a> [template](#requirement\_template) | = 2.2.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 3.56.0 |
| <a name="provider_template"></a> [template](#provider\_template) | 2.2.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_user_service_alb"></a> [user\_service\_alb](#module\_user\_service\_alb) | github.com/ministryofjustice/bichard7-next-infrastructure-modules.git//modules/ecs_cluster_alb | n/a |
| <a name="module_user_service_ecs"></a> [user\_service\_ecs](#module\_user\_service\_ecs) | github.com/ministryofjustice/bichard7-next-infrastructure-modules.git//modules/ecs_cluster | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_route53_record.user_service](https://registry.terraform.io/providers/hashicorp/aws/3.56.0/docs/resources/route53_record) | resource |
| [aws_security_group_rule.allow_alb_to_containers](https://registry.terraform.io/providers/hashicorp/aws/3.56.0/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.allow_containers_all_outbound](https://registry.terraform.io/providers/hashicorp/aws/3.56.0/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.allow_http_from_alb_to_containers](https://registry.terraform.io/providers/hashicorp/aws/3.56.0/docs/resources/security_group_rule) | resource |
| [aws_ssm_parameter.user_service_deploy_tag](https://registry.terraform.io/providers/hashicorp/aws/3.56.0/docs/resources/ssm_parameter) | resource |
| [aws_region.current](https://registry.terraform.io/providers/hashicorp/aws/3.56.0/docs/data-sources/region) | data source |
| [aws_route53_zone.public_zone](https://registry.terraform.io/providers/hashicorp/aws/3.56.0/docs/data-sources/route53_zone) | data source |
| [aws_security_group.user_service_alb](https://registry.terraform.io/providers/hashicorp/aws/3.56.0/docs/data-sources/security_group) | data source |
| [aws_security_group.user_service_ecs](https://registry.terraform.io/providers/hashicorp/aws/3.56.0/docs/data-sources/security_group) | data source |
| [template_file.user_service_fargate](https://registry.terraform.io/providers/hashicorp/template/2.2.0/docs/data-sources/file) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_admin_allowed_cidr"></a> [admin\_allowed\_cidr](#input\_admin\_allowed\_cidr) | A list of subnet CIDRs allowed to access this resource | `list(string)` | n/a | yes |
| <a name="input_cookie_secret_arn"></a> [cookie\_secret\_arn](#input\_cookie\_secret\_arn) | The arn of the Cookie Secret parameter | `string` | n/a | yes |
| <a name="input_cookies_secure"></a> [cookies\_secure](#input\_cookies\_secure) | Whether the user service should use secure cookies | `string` | `"true"` | no |
| <a name="input_crsf_form_secret_arn"></a> [crsf\_form\_secret\_arn](#input\_crsf\_form\_secret\_arn) | The arn of the CSRF Form Secret parameter | `string` | n/a | yes |
| <a name="input_csrf_cookie_secret_arn"></a> [csrf\_cookie\_secret\_arn](#input\_csrf\_cookie\_secret\_arn) | The arn of the CSRF Cookie Secret parameter | `string` | n/a | yes |
| <a name="input_db_host"></a> [db\_host](#input\_db\_host) | The FQDN or endpoint URL of our database | `string` | n/a | yes |
| <a name="input_db_password_arn"></a> [db\_password\_arn](#input\_db\_password\_arn) | The arn of the database password parameter | `string` | n/a | yes |
| <a name="input_db_ssl"></a> [db\_ssl](#input\_db\_ssl) | Whether to force an SSL connection to the Postgres DB | `bool` | `true` | no |
| <a name="input_desired_instance_count"></a> [desired\_instance\_count](#input\_desired\_instance\_count) | The number of containers we wish to provision | `number` | `1` | no |
| <a name="input_email_from_address"></a> [email\_from\_address](#input\_email\_from\_address) | The email from address our recipients see | `string` | n/a | yes |
| <a name="input_fargate_cpu"></a> [fargate\_cpu](#input\_fargate\_cpu) | The number of CPU units | `number` | n/a | yes |
| <a name="input_fargate_memory"></a> [fargate\_memory](#input\_fargate\_memory) | The amount of memory that will be given to fargate in Megabytes | `number` | n/a | yes |
| <a name="input_hide_non_prod_banner"></a> [hide\_non\_prod\_banner](#input\_hide\_non\_prod\_banner) | Whether to show the 'development environment' warning banner should be shown | `string` | `"false"` | no |
| <a name="input_incorrect_delay"></a> [incorrect\_delay](#input\_incorrect\_delay) | The amount of time (in seconds) to wait between successive login attempts for the same user | `number` | n/a | yes |
| <a name="input_jwt_secret_arn"></a> [jwt\_secret\_arn](#input\_jwt\_secret\_arn) | The arn of the JWT Secret parameter | `string` | n/a | yes |
| <a name="input_logging_bucket_name"></a> [logging\_bucket\_name](#input\_logging\_bucket\_name) | The default logging bucket for lb access logs | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | The calling layers name | `string` | n/a | yes |
| <a name="input_override_deploy_tags"></a> [override\_deploy\_tags](#input\_override\_deploy\_tags) | Required for CI/CD, do we want to allow us to overwrite the deploy tag | `bool` | `false` | no |
| <a name="input_public_zone_id"></a> [public\_zone\_id](#input\_public\_zone\_id) | The zone id for our public hosted zone so we can use ACM certificates | `string` | n/a | yes |
| <a name="input_service_subnets"></a> [service\_subnets](#input\_service\_subnets) | A list of our subnet ids to attach the tasks onto | `list(string)` | n/a | yes |
| <a name="input_smtp_host"></a> [smtp\_host](#input\_smtp\_host) | The host of our smtp server | `string` | n/a | yes |
| <a name="input_smtp_password"></a> [smtp\_password](#input\_smtp\_password) | Our smtp user password | `string` | n/a | yes |
| <a name="input_smtp_port"></a> [smtp\_port](#input\_smtp\_port) | The port we are using for the SMTP service | `number` | n/a | yes |
| <a name="input_smtp_tls"></a> [smtp\_tls](#input\_smtp\_tls) | Are we using tls encryption | `bool` | n/a | yes |
| <a name="input_smtp_user"></a> [smtp\_user](#input\_smtp\_user) | Our smtp user name for the service | `string` | n/a | yes |
| <a name="input_ssl_certificate_arn"></a> [ssl\_certificate\_arn](#input\_ssl\_certificate\_arn) | The arn of our ssl certificate | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of tags | `map(string)` | `{}` | no |
| <a name="input_token_expires_in"></a> [token\_expires\_in](#input\_token\_expires\_in) | How long the authentication tokens should be valid for after logging in | `string` | `"10 minutes"` | no |
| <a name="input_user_service_ecs_arn"></a> [user\_service\_ecs\_arn](#input\_user\_service\_ecs\_arn) | The arn of our user portal | `string` | n/a | yes |
| <a name="input_user_service_ecs_image_hash"></a> [user\_service\_ecs\_image\_hash](#input\_user\_service\_ecs\_image\_hash) | The hash of our deployable image | `string` | n/a | yes |
| <a name="input_user_service_ecs_image_url"></a> [user\_service\_ecs\_image\_url](#input\_user\_service\_ecs\_image\_url) | Our image URL to deploy | `string` | n/a | yes |
| <a name="input_user_service_log_group"></a> [user\_service\_log\_group](#input\_user\_service\_log\_group) | The log group we will be pushing our logs to | `any` | n/a | yes |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | The id of our vpc | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_external_fqdn"></a> [external\_fqdn](#output\_external\_fqdn) | The external FQDN of the user service |
| <a name="output_lb_arn"></a> [lb\_arn](#output\_lb\_arn) | The arn of our user service load balancer |
| <a name="output_target_group_arn"></a> [target\_group\_arn](#output\_target\_group\_arn) | The arn of our user service target group |
| <a name="output_user_service_dns_lb"></a> [user\_service\_dns\_lb](#output\_user\_service\_dns\_lb) | DNS entry for user service load balancer |
<!-- END_TF_DOCS -->
