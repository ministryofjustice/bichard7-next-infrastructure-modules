# Postfix VPC

Provisions a seperate VPC with 3 postfix instances. These instances are configured  to consume certificate provided to us to
allow relay mail sending. The vpc exposes a service endpoint for the application to consume.

There is also an autoscaling group with a bastion instance to allow to ssh into the postfix instances.

Configuration management is done via an ansible playbook.

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.13 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | = 3.56.0 |
| <a name="requirement_tls"></a> [tls](#requirement\_tls) | = 3.1.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 3.56.0 |
| <a name="provider_random"></a> [random](#provider\_random) | 3.1.0 |
| <a name="provider_template"></a> [template](#provider\_template) | 2.2.0 |
| <a name="provider_tls"></a> [tls](#provider\_tls) | 3.1.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_postfix_ecs_cluster"></a> [postfix\_ecs\_cluster](#module\_postfix\_ecs\_cluster) | github.com/ministryofjustice/bichard7-next-infrastructure-modules.git//modules/ecs_cluster | n/a |
| <a name="module_postfix_vpc"></a> [postfix\_vpc](#module\_postfix\_vpc) | terraform-aws-modules/vpc/aws | 3.0.0 |
| <a name="module_smtp_nginx_self_signed_certificate"></a> [smtp\_nginx\_self\_signed\_certificate](#module\_smtp\_nginx\_self\_signed\_certificate) | github.com/ministryofjustice/bichard7-next-infrastructure-modules.git//modules/self_signed_certificate | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_autoscaling_group.bastion](https://registry.terraform.io/providers/hashicorp/aws/3.56.0/docs/resources/autoscaling_group) | resource |
| [aws_cloudwatch_log_group.postfix_log_group](https://registry.terraform.io/providers/hashicorp/aws/3.56.0/docs/resources/cloudwatch_log_group) | resource |
| [aws_cloudwatch_metric_alarm.cpu_usage](https://registry.terraform.io/providers/hashicorp/aws/3.56.0/docs/resources/cloudwatch_metric_alarm) | resource |
| [aws_cloudwatch_metric_alarm.healthy_instances](https://registry.terraform.io/providers/hashicorp/aws/3.56.0/docs/resources/cloudwatch_metric_alarm) | resource |
| [aws_cloudwatch_metric_alarm.instance_errors](https://registry.terraform.io/providers/hashicorp/aws/3.56.0/docs/resources/cloudwatch_metric_alarm) | resource |
| [aws_cloudwatch_metric_alarm.instance_system_errors](https://registry.terraform.io/providers/hashicorp/aws/3.56.0/docs/resources/cloudwatch_metric_alarm) | resource |
| [aws_cloudwatch_metric_alarm.memory_usage](https://registry.terraform.io/providers/hashicorp/aws/3.56.0/docs/resources/cloudwatch_metric_alarm) | resource |
| [aws_cloudwatch_metric_alarm.percentage_disk_used](https://registry.terraform.io/providers/hashicorp/aws/3.56.0/docs/resources/cloudwatch_metric_alarm) | resource |
| [aws_eip.nat_gateway_static_ip](https://registry.terraform.io/providers/hashicorp/aws/3.56.0/docs/resources/eip) | resource |
| [aws_eip.postfix_static_ip](https://registry.terraform.io/providers/hashicorp/aws/3.56.0/docs/resources/eip) | resource |
| [aws_iam_instance_profile.bastion_instance_profile](https://registry.terraform.io/providers/hashicorp/aws/3.56.0/docs/resources/iam_instance_profile) | resource |
| [aws_iam_instance_profile.postfix_instance_profile](https://registry.terraform.io/providers/hashicorp/aws/3.56.0/docs/resources/iam_instance_profile) | resource |
| [aws_iam_role.bastion_role](https://registry.terraform.io/providers/hashicorp/aws/3.56.0/docs/resources/iam_role) | resource |
| [aws_iam_role.postfix_role](https://registry.terraform.io/providers/hashicorp/aws/3.56.0/docs/resources/iam_role) | resource |
| [aws_iam_role_policy.allow_bastion_ssm_access](https://registry.terraform.io/providers/hashicorp/aws/3.56.0/docs/resources/iam_role_policy) | resource |
| [aws_iam_role_policy.postfix_allow_ssm](https://registry.terraform.io/providers/hashicorp/aws/3.56.0/docs/resources/iam_role_policy) | resource |
| [aws_iam_role_policy.postfix_cloudwatch_logs](https://registry.terraform.io/providers/hashicorp/aws/3.56.0/docs/resources/iam_role_policy) | resource |
| [aws_iam_role_policy_attachment.postfix_cloudwatch_agent](https://registry.terraform.io/providers/hashicorp/aws/3.56.0/docs/resources/iam_role_policy_attachment) | resource |
| [aws_instance.postfix](https://registry.terraform.io/providers/hashicorp/aws/3.56.0/docs/resources/instance) | resource |
| [aws_key_pair.aws_keypair](https://registry.terraform.io/providers/hashicorp/aws/3.56.0/docs/resources/key_pair) | resource |
| [aws_kms_alias.logging_encryption_key_alias](https://registry.terraform.io/providers/hashicorp/aws/3.56.0/docs/resources/kms_alias) | resource |
| [aws_kms_key.logging_encryption_key](https://registry.terraform.io/providers/hashicorp/aws/3.56.0/docs/resources/kms_key) | resource |
| [aws_launch_template.bastion](https://registry.terraform.io/providers/hashicorp/aws/3.56.0/docs/resources/launch_template) | resource |
| [aws_lb.postfix_nlb](https://registry.terraform.io/providers/hashicorp/aws/3.56.0/docs/resources/lb) | resource |
| [aws_lb_listener.postfix_prometheus_node_exporter](https://registry.terraform.io/providers/hashicorp/aws/3.56.0/docs/resources/lb_listener) | resource |
| [aws_lb_listener.postfix_prometheus_postfix_exporter](https://registry.terraform.io/providers/hashicorp/aws/3.56.0/docs/resources/lb_listener) | resource |
| [aws_lb_listener.postfix_smtp](https://registry.terraform.io/providers/hashicorp/aws/3.56.0/docs/resources/lb_listener) | resource |
| [aws_lb_listener.postfix_smtps](https://registry.terraform.io/providers/hashicorp/aws/3.56.0/docs/resources/lb_listener) | resource |
| [aws_lb_target_group.postfix_prometheus_node_exporter](https://registry.terraform.io/providers/hashicorp/aws/3.56.0/docs/resources/lb_target_group) | resource |
| [aws_lb_target_group.postfix_prometheus_postfix_exporter](https://registry.terraform.io/providers/hashicorp/aws/3.56.0/docs/resources/lb_target_group) | resource |
| [aws_lb_target_group.postfix_smtp](https://registry.terraform.io/providers/hashicorp/aws/3.56.0/docs/resources/lb_target_group) | resource |
| [aws_lb_target_group.postfix_smtps](https://registry.terraform.io/providers/hashicorp/aws/3.56.0/docs/resources/lb_target_group) | resource |
| [aws_lb_target_group_attachment.postfix_prometheus_node_exporter](https://registry.terraform.io/providers/hashicorp/aws/3.56.0/docs/resources/lb_target_group_attachment) | resource |
| [aws_lb_target_group_attachment.postfix_prometheus_postfix_exporter](https://registry.terraform.io/providers/hashicorp/aws/3.56.0/docs/resources/lb_target_group_attachment) | resource |
| [aws_lb_target_group_attachment.postfix_smtp](https://registry.terraform.io/providers/hashicorp/aws/3.56.0/docs/resources/lb_target_group_attachment) | resource |
| [aws_lb_target_group_attachment.postfix_smtps](https://registry.terraform.io/providers/hashicorp/aws/3.56.0/docs/resources/lb_target_group_attachment) | resource |
| [aws_network_interface.static_ip](https://registry.terraform.io/providers/hashicorp/aws/3.56.0/docs/resources/network_interface) | resource |
| [aws_route53_record.mail](https://registry.terraform.io/providers/hashicorp/aws/3.56.0/docs/resources/route53_record) | resource |
| [aws_s3_bucket.vpc_flow_logs_bucket](https://registry.terraform.io/providers/hashicorp/aws/3.56.0/docs/resources/s3_bucket) | resource |
| [aws_s3_bucket_public_access_block.vpc_flow_logs_bucket](https://registry.terraform.io/providers/hashicorp/aws/3.56.0/docs/resources/s3_bucket_public_access_block) | resource |
| [aws_security_group.bastion](https://registry.terraform.io/providers/hashicorp/aws/3.56.0/docs/resources/security_group) | resource |
| [aws_security_group.postfix_container](https://registry.terraform.io/providers/hashicorp/aws/3.56.0/docs/resources/security_group) | resource |
| [aws_security_group.postfix_instance](https://registry.terraform.io/providers/hashicorp/aws/3.56.0/docs/resources/security_group) | resource |
| [aws_security_group.postfix_nlb](https://registry.terraform.io/providers/hashicorp/aws/3.56.0/docs/resources/security_group) | resource |
| [aws_security_group.postfix_vpc_sg](https://registry.terraform.io/providers/hashicorp/aws/3.56.0/docs/resources/security_group) | resource |
| [aws_security_group.postfix_vpce](https://registry.terraform.io/providers/hashicorp/aws/3.56.0/docs/resources/security_group) | resource |
| [aws_security_group_rule.allow_https_egress](https://registry.terraform.io/providers/hashicorp/aws/3.56.0/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.allow_https_from_bastion](https://registry.terraform.io/providers/hashicorp/aws/3.56.0/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.allow_node_exporter_ingress_from_the_application](https://registry.terraform.io/providers/hashicorp/aws/3.56.0/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.allow_node_exporter_to_instance_from_vpce](https://registry.terraform.io/providers/hashicorp/aws/3.56.0/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.allow_postfix_exporter_ingress_from_the_application](https://registry.terraform.io/providers/hashicorp/aws/3.56.0/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.allow_postfix_vpce_smtp_egress](https://registry.terraform.io/providers/hashicorp/aws/3.56.0/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.allow_postfix_vpce_smtps_egress](https://registry.terraform.io/providers/hashicorp/aws/3.56.0/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.allow_prometheus_node_exporter_to_instance_from_private_subnets](https://registry.terraform.io/providers/hashicorp/aws/3.56.0/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.allow_prometheus_postfix_exporter_to_instance_from_private_subnets](https://registry.terraform.io/providers/hashicorp/aws/3.56.0/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.allow_smtp_alternate_port_to_cjsm_net](https://registry.terraform.io/providers/hashicorp/aws/3.56.0/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.allow_smtp_ingress_from_the_application](https://registry.terraform.io/providers/hashicorp/aws/3.56.0/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.allow_smtp_to_cjsm_net](https://registry.terraform.io/providers/hashicorp/aws/3.56.0/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.allow_smtp_to_instance_from_private_subnets](https://registry.terraform.io/providers/hashicorp/aws/3.56.0/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.allow_smtp_to_instance_from_vpce](https://registry.terraform.io/providers/hashicorp/aws/3.56.0/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.allow_smtps_ingress_from_the_application](https://registry.terraform.io/providers/hashicorp/aws/3.56.0/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.allow_smtps_to_instance_from_private_subnets](https://registry.terraform.io/providers/hashicorp/aws/3.56.0/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.allow_smtps_to_instance_from_vpce](https://registry.terraform.io/providers/hashicorp/aws/3.56.0/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.allow_ssh_from_bastion_to_private_vpc](https://registry.terraform.io/providers/hashicorp/aws/3.56.0/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.allow_ssh_ingress_from_bastion](https://registry.terraform.io/providers/hashicorp/aws/3.56.0/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.allow_ssh_ingress_from_world_bastion_instance](https://registry.terraform.io/providers/hashicorp/aws/3.56.0/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.allow_vpc_endpoint_secure_smtp_ingress](https://registry.terraform.io/providers/hashicorp/aws/3.56.0/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.allow_vpc_endpoint_smtp_ingress](https://registry.terraform.io/providers/hashicorp/aws/3.56.0/docs/resources/security_group_rule) | resource |
| [aws_ssm_parameter.cloudwatch_agent_configuration_file](https://registry.terraform.io/providers/hashicorp/aws/3.56.0/docs/resources/ssm_parameter) | resource |
| [aws_ssm_parameter.postfix_remote_password](https://registry.terraform.io/providers/hashicorp/aws/3.56.0/docs/resources/ssm_parameter) | resource |
| [aws_ssm_parameter.postfix_remote_user](https://registry.terraform.io/providers/hashicorp/aws/3.56.0/docs/resources/ssm_parameter) | resource |
| [aws_ssm_parameter.private_key](https://registry.terraform.io/providers/hashicorp/aws/3.56.0/docs/resources/ssm_parameter) | resource |
| [aws_ssm_parameter.public_domain_signing_key](https://registry.terraform.io/providers/hashicorp/aws/3.56.0/docs/resources/ssm_parameter) | resource |
| [aws_ssm_parameter.public_domain_smtp_csr](https://registry.terraform.io/providers/hashicorp/aws/3.56.0/docs/resources/ssm_parameter) | resource |
| [aws_vpc_endpoint_service.postfix](https://registry.terraform.io/providers/hashicorp/aws/3.56.0/docs/resources/vpc_endpoint_service) | resource |
| [random_password.postfix_remote_password](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/password) | resource |
| [tls_cert_request.public_domain_signing_certificate](https://registry.terraform.io/providers/hashicorp/tls/3.1.0/docs/resources/cert_request) | resource |
| [tls_private_key.aws_keypair](https://registry.terraform.io/providers/hashicorp/tls/3.1.0/docs/resources/private_key) | resource |
| [tls_private_key.public_domain_signing_key](https://registry.terraform.io/providers/hashicorp/tls/3.1.0/docs/resources/private_key) | resource |
| [aws_ami.amazon_linux_2](https://registry.terraform.io/providers/hashicorp/aws/3.56.0/docs/data-sources/ami) | data source |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/3.56.0/docs/data-sources/caller_identity) | data source |
| [aws_region.current](https://registry.terraform.io/providers/hashicorp/aws/3.56.0/docs/data-sources/region) | data source |
| [aws_route53_zone.public](https://registry.terraform.io/providers/hashicorp/aws/3.56.0/docs/data-sources/route53_zone) | data source |
| [aws_security_group.user_service_container](https://registry.terraform.io/providers/hashicorp/aws/3.56.0/docs/data-sources/security_group) | data source |
| [aws_ssm_parameter.cjse_client_certificate](https://registry.terraform.io/providers/hashicorp/aws/3.56.0/docs/data-sources/ssm_parameter) | data source |
| [aws_ssm_parameter.cjse_relay_password](https://registry.terraform.io/providers/hashicorp/aws/3.56.0/docs/data-sources/ssm_parameter) | data source |
| [aws_ssm_parameter.cjse_relay_user](https://registry.terraform.io/providers/hashicorp/aws/3.56.0/docs/data-sources/ssm_parameter) | data source |
| [aws_ssm_parameter.cjse_root_certificate](https://registry.terraform.io/providers/hashicorp/aws/3.56.0/docs/data-sources/ssm_parameter) | data source |
| [template_file.allow_kms](https://registry.terraform.io/providers/hashicorp/template/latest/docs/data-sources/file) | data source |
| [template_file.bastion_allow_ssm_parameters](https://registry.terraform.io/providers/hashicorp/template/latest/docs/data-sources/file) | data source |
| [template_file.bastion_cloudwatch_agent](https://registry.terraform.io/providers/hashicorp/template/latest/docs/data-sources/file) | data source |
| [template_file.bastion_instance_userdata](https://registry.terraform.io/providers/hashicorp/template/latest/docs/data-sources/file) | data source |
| [template_file.postfix_allow_ssm_parameters](https://registry.terraform.io/providers/hashicorp/template/latest/docs/data-sources/file) | data source |
| [template_file.postfix_ansible_playbook](https://registry.terraform.io/providers/hashicorp/template/latest/docs/data-sources/file) | data source |
| [template_file.postfix_ecs_task](https://registry.terraform.io/providers/hashicorp/template/latest/docs/data-sources/file) | data source |
| [template_file.postfix_instance_userdata](https://registry.terraform.io/providers/hashicorp/template/latest/docs/data-sources/file) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_application_cidr"></a> [application\_cidr](#input\_application\_cidr) | The application cidr block | `list(string)` | n/a | yes |
| <a name="input_aws_logs_bucket"></a> [aws\_logs\_bucket](#input\_aws\_logs\_bucket) | The bucket we use to log all of our bucket actions | `string` | n/a | yes |
| <a name="input_bastion_count"></a> [bastion\_count](#input\_bastion\_count) | How many bastion instances do we want | `number` | `1` | no |
| <a name="input_cloudwatch_notifications_arn"></a> [cloudwatch\_notifications\_arn](#input\_cloudwatch\_notifications\_arn) | The arn of our cloudwatch sns notifications arn | `string` | n/a | yes |
| <a name="input_ingress_cidr_blocks"></a> [ingress\_cidr\_blocks](#input\_ingress\_cidr\_blocks) | A list of ingress cidr blocks to route to our private cidrs | `list(string)` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | The name from our label module | `string` | n/a | yes |
| <a name="input_postfix_image_hash"></a> [postfix\_image\_hash](#input\_postfix\_image\_hash) | The ecr sha256hash for our postfix image | `string` | n/a | yes |
| <a name="input_postfix_repository_arn"></a> [postfix\_repository\_arn](#input\_postfix\_repository\_arn) | The repository arn for our postfix ecr image | `string` | n/a | yes |
| <a name="input_public_zone_id"></a> [public\_zone\_id](#input\_public\_zone\_id) | The public zone we use to create records on | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of resource tags | `map(string)` | n/a | yes |
| <a name="input_vpc_cidr_block"></a> [vpc\_cidr\_block](#input\_vpc\_cidr\_block) | Our cidr block to apply to this vpc | `string` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_instance_ipv4_address"></a> [instance\_ipv4\_address](#output\_instance\_ipv4\_address) | The static private IPV4 addresses of our postfix instance |
| <a name="output_instance_ipv4_cidr"></a> [instance\_ipv4\_cidr](#output\_instance\_ipv4\_cidr) | The static private IPV4 addresses of our postfix instance in cidr notation |
| <a name="output_postfix_instance_profile_arn"></a> [postfix\_instance\_profile\_arn](#output\_postfix\_instance\_profile\_arn) | The arn of our postfix instance profile |
| <a name="output_postfix_vpc"></a> [postfix\_vpc](#output\_postfix\_vpc) | The outputs from our postfix VPC |
| <a name="output_postfix_vpc_nat_gateway_ip"></a> [postfix\_vpc\_nat\_gateway\_ip](#output\_postfix\_vpc\_nat\_gateway\_ip) | The ips of our external nat gateway, this will be presented to cjsm |
| <a name="output_postfix_vpce_security_group_id"></a> [postfix\_vpce\_security\_group\_id](#output\_postfix\_vpce\_security\_group\_id) | The id of the vpce |
| <a name="output_postfix_vpce_service"></a> [postfix\_vpce\_service](#output\_postfix\_vpce\_service) | The vpce service we are going to consume in the application |
<!-- END_TF_DOCS -->
