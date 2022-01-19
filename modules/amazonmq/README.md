# AmazonMQ

Module to create amazon mq cluster


<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.13 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | = 3.72.0 |
| <a name="requirement_random"></a> [random](#requirement\_random) | = 3.0.1 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | = 3.72.0 |
| <a name="provider_random"></a> [random](#provider\_random) | = 3.0.1 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_cloudwatch_log_resource_policy.amazon-mq-log-publishing-policy](https://registry.terraform.io/providers/hashicorp/aws/3.72.0/docs/resources/cloudwatch_log_resource_policy) | resource |
| [aws_kms_alias.amq](https://registry.terraform.io/providers/hashicorp/aws/3.72.0/docs/resources/kms_alias) | resource |
| [aws_kms_key.amq_encryption_key](https://registry.terraform.io/providers/hashicorp/aws/3.72.0/docs/resources/kms_key) | resource |
| [aws_mq_broker.amq](https://registry.terraform.io/providers/hashicorp/aws/3.72.0/docs/resources/mq_broker) | resource |
| [aws_mq_configuration.amq](https://registry.terraform.io/providers/hashicorp/aws/3.72.0/docs/resources/mq_configuration) | resource |
| [aws_route53_record.mq](https://registry.terraform.io/providers/hashicorp/aws/3.72.0/docs/resources/route53_record) | resource |
| [aws_security_group_rule.amq_allow_all_egress_to_was_backend](https://registry.terraform.io/providers/hashicorp/aws/3.72.0/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.amq_allow_all_egress_to_was_web](https://registry.terraform.io/providers/hashicorp/aws/3.72.0/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.amq_allow_egress](https://registry.terraform.io/providers/hashicorp/aws/3.72.0/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.amq_allow_queue_vpc_ingress_openwire](https://registry.terraform.io/providers/hashicorp/aws/3.72.0/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.amq_allow_queue_vpc_ingress_stomp](https://registry.terraform.io/providers/hashicorp/aws/3.72.0/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.was_backend_ingress_to_amq_openwire](https://registry.terraform.io/providers/hashicorp/aws/3.72.0/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.was_backendingress_to_amq_stomp](https://registry.terraform.io/providers/hashicorp/aws/3.72.0/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.was_web_ingress_to_amq_openwire](https://registry.terraform.io/providers/hashicorp/aws/3.72.0/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.was_web_ingress_to_amq_stomp](https://registry.terraform.io/providers/hashicorp/aws/3.72.0/docs/resources/security_group_rule) | resource |
| [aws_ssm_parameter.amq_password](https://registry.terraform.io/providers/hashicorp/aws/3.72.0/docs/resources/ssm_parameter) | resource |
| [random_password.amq](https://registry.terraform.io/providers/hashicorp/random/3.0.1/docs/resources/password) | resource |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/3.72.0/docs/data-sources/caller_identity) | data source |
| [aws_iam_policy_document.amazon_mq_log_publishing_policy](https://registry.terraform.io/providers/hashicorp/aws/3.72.0/docs/data-sources/iam_policy_document) | data source |
| [aws_route53_zone.cjse_dot_org](https://registry.terraform.io/providers/hashicorp/aws/3.72.0/docs/data-sources/route53_zone) | data source |
| [aws_security_group.amq](https://registry.terraform.io/providers/hashicorp/aws/3.72.0/docs/data-sources/security_group) | data source |
| [aws_security_group.bichard7_backend](https://registry.terraform.io/providers/hashicorp/aws/3.72.0/docs/data-sources/security_group) | data source |
| [aws_security_group.bichard7_web](https://registry.terraform.io/providers/hashicorp/aws/3.72.0/docs/data-sources/security_group) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_allowed_cidrs"></a> [allowed\_cidrs](#input\_allowed\_cidrs) | The CIDR blocks allowed to connect to Amazon MQ | `list(string)` | n/a | yes |
| <a name="input_amq_master_username"></a> [amq\_master\_username](#input\_amq\_master\_username) | The master username for the rds instance | `string` | n/a | yes |
| <a name="input_broker_instance_type"></a> [broker\_instance\_type](#input\_broker\_instance\_type) | The instance type we want to use for our broker | `string` | `"mq.t2.micro"` | no |
| <a name="input_environment_name"></a> [environment\_name](#input\_environment\_name) | The name of the environment | `string` | n/a | yes |
| <a name="input_private_subnet_ids"></a> [private\_subnet\_ids](#input\_private\_subnet\_ids) | The ID's of the VPC subnets that the RDS cluster instances will be created in | `list(string)` | n/a | yes |
| <a name="input_private_zone_id"></a> [private\_zone\_id](#input\_private\_zone\_id) | The private hosted zone | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | The tags for the resources | `map(string)` | n/a | yes |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | The ID of the VPC that the RDS cluster will be created in | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_amq_arn"></a> [amq\_arn](#output\_amq\_arn) | The ARN of the AmazonMQ broker |
| <a name="output_internal_fqdn"></a> [internal\_fqdn](#output\_internal\_fqdn) | The internal FQDN of our db |
| <a name="output_messaging_endpoint"></a> [messaging\_endpoint](#output\_messaging\_endpoint) | The messaging endpoint url |
| <a name="output_openwire_url"></a> [openwire\_url](#output\_openwire\_url) | A generated URL for the ActiveMQ endpoint over the OpenWire protocol |
| <a name="output_password_arn"></a> [password\_arn](#output\_password\_arn) | The ARN for the password in SSM |
| <a name="output_password_value"></a> [password\_value](#output\_password\_value) | The value of the MQ password |
| <a name="output_stomp_url"></a> [stomp\_url](#output\_stomp\_url) | A generated URL for the ActiveMQ endpoint over the Stomp protocol |
<!-- END_TF_DOCS -->
