## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.13 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | = 3.56.0 |
| <a name="requirement_external"></a> [external](#requirement\_external) | = 2.1.0 |
| <a name="requirement_local"></a> [local](#requirement\_local) | = 2.0.0 |
| <a name="requirement_random"></a> [random](#requirement\_random) | = 3.0.1 |
| <a name="requirement_template"></a> [template](#requirement\_template) | = 2.2.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 3.56.0 |
| <a name="provider_external"></a> [external](#provider\_external) | 2.1.0 |
| <a name="provider_random"></a> [random](#provider\_random) | 3.0.1 |
| <a name="provider_template"></a> [template](#provider\_template) | 2.2.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_scanning_portal_ecs_alb"></a> [scanning\_portal\_ecs\_alb](#module\_scanning\_portal\_ecs\_alb) | github.com/ministryofjustice/bichard7-next-infrastructure-modules.git//modules/ecs_cluster_alb | n/a |
| <a name="module_scanning_portal_ecs_service"></a> [scanning\_portal\_ecs\_service](#module\_scanning\_portal\_ecs\_service) | github.com/ministryofjustice/bichard7-next-infrastructure-modules.git//modules/ecs_cluster | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_cloudwatch_log_group.ecs_log_group](https://registry.terraform.io/providers/hashicorp/aws/3.56.0/docs/resources/cloudwatch_log_group) | resource |
| [aws_iam_access_key.scanning_bucket_user](https://registry.terraform.io/providers/hashicorp/aws/3.56.0/docs/resources/iam_access_key) | resource |
| [aws_iam_user.scanning_bucket_user](https://registry.terraform.io/providers/hashicorp/aws/3.56.0/docs/resources/iam_user) | resource |
| [aws_iam_user_policy.scanning_user_policy](https://registry.terraform.io/providers/hashicorp/aws/3.56.0/docs/resources/iam_user_policy) | resource |
| [aws_kms_alias.cloudwatch_kms_alias](https://registry.terraform.io/providers/hashicorp/aws/3.56.0/docs/resources/kms_alias) | resource |
| [aws_kms_key.cloudwatch_encryption](https://registry.terraform.io/providers/hashicorp/aws/3.56.0/docs/resources/kms_key) | resource |
| [aws_route53_record.friendly_dns_name](https://registry.terraform.io/providers/hashicorp/aws/3.56.0/docs/resources/route53_record) | resource |
| [aws_security_group.scanning_portal_alb](https://registry.terraform.io/providers/hashicorp/aws/3.56.0/docs/resources/security_group) | resource |
| [aws_security_group.scanning_portal_container](https://registry.terraform.io/providers/hashicorp/aws/3.56.0/docs/resources/security_group) | resource |
| [aws_security_group_rule.allow_alb_https_egress_to_ecs](https://registry.terraform.io/providers/hashicorp/aws/3.56.0/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.allow_http_ingress_on_alb_from_world](https://registry.terraform.io/providers/hashicorp/aws/3.56.0/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.allow_https_egress_from_container_to_world](https://registry.terraform.io/providers/hashicorp/aws/3.56.0/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.allow_https_ingress_on_alb_from_world](https://registry.terraform.io/providers/hashicorp/aws/3.56.0/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.allow_https_ingress_on_container_from_alb](https://registry.terraform.io/providers/hashicorp/aws/3.56.0/docs/resources/security_group_rule) | resource |
| [aws_ssm_parameter.scanning_bucket_access_key](https://registry.terraform.io/providers/hashicorp/aws/3.56.0/docs/resources/ssm_parameter) | resource |
| [aws_ssm_parameter.scanning_bucket_secret_key](https://registry.terraform.io/providers/hashicorp/aws/3.56.0/docs/resources/ssm_parameter) | resource |
| [aws_ssm_parameter.scanning_portal_password](https://registry.terraform.io/providers/hashicorp/aws/3.56.0/docs/resources/ssm_parameter) | resource |
| [aws_ssm_parameter.scanning_portal_username](https://registry.terraform.io/providers/hashicorp/aws/3.56.0/docs/resources/ssm_parameter) | resource |
| [random_password.scanning_portal_password](https://registry.terraform.io/providers/hashicorp/random/3.0.1/docs/resources/password) | resource |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/3.56.0/docs/data-sources/caller_identity) | data source |
| [aws_ecr_repository.scanning_portal](https://registry.terraform.io/providers/hashicorp/aws/3.56.0/docs/data-sources/ecr_repository) | data source |
| [aws_region.current](https://registry.terraform.io/providers/hashicorp/aws/3.56.0/docs/data-sources/region) | data source |
| [aws_route53_zone.public](https://registry.terraform.io/providers/hashicorp/aws/3.56.0/docs/data-sources/route53_zone) | data source |
| [external_external.scanning_portal_latest_image](https://registry.terraform.io/providers/hashicorp/external/2.1.0/docs/data-sources/external) | data source |
| [template_file.scanning_reults_portal_fargate](https://registry.terraform.io/providers/hashicorp/template/2.2.0/docs/data-sources/file) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_desired_instance_count"></a> [desired\_instance\_count](#input\_desired\_instance\_count) | The number of instances we wish to deploy | `number` | `1` | no |
| <a name="input_fargate_cpu"></a> [fargate\_cpu](#input\_fargate\_cpu) | The number of cpu units | `number` | n/a | yes |
| <a name="input_fargate_memory"></a> [fargate\_memory](#input\_fargate\_memory) | The amount of memory that will be given to fargate in Megabytes | `number` | n/a | yes |
| <a name="input_logging_bucket_name"></a> [logging\_bucket\_name](#input\_logging\_bucket\_name) | The default logging bucket for lb access logs | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | The calling layers name | `string` | n/a | yes |
| <a name="input_public_zone_id"></a> [public\_zone\_id](#input\_public\_zone\_id) | The public zone id that we will host against | `string` | n/a | yes |
| <a name="input_scanning_bucket_name"></a> [scanning\_bucket\_name](#input\_scanning\_bucket\_name) | The name of the bucket we need to connect to | `string` | n/a | yes |
| <a name="input_self_signed_certificate"></a> [self\_signed\_certificate](#input\_self\_signed\_certificate) | A map of strings from our self signed certificate | `map(string)` | n/a | yes |
| <a name="input_service_subnets"></a> [service\_subnets](#input\_service\_subnets) | A list of our subnet ids to attach the tasks onto | `list(string)` | n/a | yes |
| <a name="input_ssl_certificate_arn"></a> [ssl\_certificate\_arn](#input\_ssl\_certificate\_arn) | The arn of our ssl certificate | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of tags | `map(string)` | `{}` | no |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | The id of our vpc | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_scanning_alb_dns"></a> [scanning\_alb\_dns](#output\_scanning\_alb\_dns) | DNS entry for load balancer |
| <a name="output_scanning_fqdn"></a> [scanning\_fqdn](#output\_scanning\_fqdn) | The public fqdn for the alb |

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.13 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | = 3.75.2 |
| <a name="requirement_external"></a> [external](#requirement\_external) | = 2.1.0 |
| <a name="requirement_local"></a> [local](#requirement\_local) | = 2.0.0 |
| <a name="requirement_random"></a> [random](#requirement\_random) | = 3.0.1 |
| <a name="requirement_template"></a> [template](#requirement\_template) | = 2.2.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 3.72.0 |
| <a name="provider_external"></a> [external](#provider\_external) | 2.1.0 |
| <a name="provider_random"></a> [random](#provider\_random) | 3.0.1 |
| <a name="provider_template"></a> [template](#provider\_template) | 2.2.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_scanning_portal_ecs_alb"></a> [scanning\_portal\_ecs\_alb](#module\_scanning\_portal\_ecs\_alb) | github.com/ministryofjustice/bichard7-next-infrastructure-modules.git//modules/ecs_cluster_alb | n/a |
| <a name="module_scanning_portal_ecs_service"></a> [scanning\_portal\_ecs\_service](#module\_scanning\_portal\_ecs\_service) | github.com/ministryofjustice/bichard7-next-infrastructure-modules.git//modules/ecs_cluster | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_cloudwatch_log_group.ecs_log_group](https://registry.terraform.io/providers/hashicorp/aws/3.75.2/docs/resources/cloudwatch_log_group) | resource |
| [aws_iam_access_key.scanning_bucket_user](https://registry.terraform.io/providers/hashicorp/aws/3.75.2/docs/resources/iam_access_key) | resource |
| [aws_iam_user.scanning_bucket_user](https://registry.terraform.io/providers/hashicorp/aws/3.75.2/docs/resources/iam_user) | resource |
| [aws_iam_user_policy.scanning_user_policy](https://registry.terraform.io/providers/hashicorp/aws/3.75.2/docs/resources/iam_user_policy) | resource |
| [aws_kms_alias.cloudwatch_kms_alias](https://registry.terraform.io/providers/hashicorp/aws/3.75.2/docs/resources/kms_alias) | resource |
| [aws_kms_key.cloudwatch_encryption](https://registry.terraform.io/providers/hashicorp/aws/3.75.2/docs/resources/kms_key) | resource |
| [aws_route53_record.friendly_dns_name](https://registry.terraform.io/providers/hashicorp/aws/3.75.2/docs/resources/route53_record) | resource |
| [aws_security_group.scanning_portal_alb](https://registry.terraform.io/providers/hashicorp/aws/3.75.2/docs/resources/security_group) | resource |
| [aws_security_group.scanning_portal_container](https://registry.terraform.io/providers/hashicorp/aws/3.75.2/docs/resources/security_group) | resource |
| [aws_security_group_rule.allow_alb_https_egress_to_ecs](https://registry.terraform.io/providers/hashicorp/aws/3.75.2/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.allow_http_ingress_on_alb_from_world](https://registry.terraform.io/providers/hashicorp/aws/3.75.2/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.allow_https_egress_from_container_to_world](https://registry.terraform.io/providers/hashicorp/aws/3.75.2/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.allow_https_ingress_on_alb_from_world](https://registry.terraform.io/providers/hashicorp/aws/3.75.2/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.allow_https_ingress_on_container_from_alb](https://registry.terraform.io/providers/hashicorp/aws/3.75.2/docs/resources/security_group_rule) | resource |
| [aws_ssm_parameter.scanning_bucket_access_key](https://registry.terraform.io/providers/hashicorp/aws/3.75.2/docs/resources/ssm_parameter) | resource |
| [aws_ssm_parameter.scanning_bucket_secret_key](https://registry.terraform.io/providers/hashicorp/aws/3.75.2/docs/resources/ssm_parameter) | resource |
| [aws_ssm_parameter.scanning_portal_password](https://registry.terraform.io/providers/hashicorp/aws/3.75.2/docs/resources/ssm_parameter) | resource |
| [aws_ssm_parameter.scanning_portal_username](https://registry.terraform.io/providers/hashicorp/aws/3.75.2/docs/resources/ssm_parameter) | resource |
| [random_password.scanning_portal_password](https://registry.terraform.io/providers/hashicorp/random/3.0.1/docs/resources/password) | resource |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/3.75.2/docs/data-sources/caller_identity) | data source |
| [aws_ecr_repository.scanning_portal](https://registry.terraform.io/providers/hashicorp/aws/3.75.2/docs/data-sources/ecr_repository) | data source |
| [aws_region.current](https://registry.terraform.io/providers/hashicorp/aws/3.75.2/docs/data-sources/region) | data source |
| [aws_route53_zone.public](https://registry.terraform.io/providers/hashicorp/aws/3.75.2/docs/data-sources/route53_zone) | data source |
| [external_external.scanning_portal_latest_image](https://registry.terraform.io/providers/hashicorp/external/2.1.0/docs/data-sources/external) | data source |
| [template_file.cloudwatch_encryption](https://registry.terraform.io/providers/hashicorp/template/2.2.0/docs/data-sources/file) | data source |
| [template_file.scanning_reults_portal_fargate](https://registry.terraform.io/providers/hashicorp/template/2.2.0/docs/data-sources/file) | data source |
| [template_file.scanning_user_policy](https://registry.terraform.io/providers/hashicorp/template/2.2.0/docs/data-sources/file) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_desired_instance_count"></a> [desired\_instance\_count](#input\_desired\_instance\_count) | The number of instances we wish to deploy | `number` | `1` | no |
| <a name="input_fargate_cpu"></a> [fargate\_cpu](#input\_fargate\_cpu) | The number of cpu units | `number` | n/a | yes |
| <a name="input_fargate_memory"></a> [fargate\_memory](#input\_fargate\_memory) | The amount of memory that will be given to fargate in Megabytes | `number` | n/a | yes |
| <a name="input_logging_bucket_name"></a> [logging\_bucket\_name](#input\_logging\_bucket\_name) | The default logging bucket for lb access logs | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | The calling layers name | `string` | n/a | yes |
| <a name="input_public_zone_id"></a> [public\_zone\_id](#input\_public\_zone\_id) | The public zone id that we will host against | `string` | n/a | yes |
| <a name="input_scanning_bucket_name"></a> [scanning\_bucket\_name](#input\_scanning\_bucket\_name) | The name of the bucket we need to connect to | `string` | n/a | yes |
| <a name="input_self_signed_certificate"></a> [self\_signed\_certificate](#input\_self\_signed\_certificate) | A map of strings from our self signed certificate | `map(string)` | n/a | yes |
| <a name="input_service_subnets"></a> [service\_subnets](#input\_service\_subnets) | A list of our subnet ids to attach the tasks onto | `list(string)` | n/a | yes |
| <a name="input_ssl_certificate_arn"></a> [ssl\_certificate\_arn](#input\_ssl\_certificate\_arn) | The arn of our ssl certificate | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of tags | `map(string)` | `{}` | no |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | The id of our vpc | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_scanning_alb_dns"></a> [scanning\_alb\_dns](#output\_scanning\_alb\_dns) | DNS entry for load balancer |
| <a name="output_scanning_fqdn"></a> [scanning\_fqdn](#output\_scanning\_fqdn) | The public fqdn for the alb |
<!-- END_TF_DOCS -->
