# Opensearch

Module to provision opensearch and using the opensearch api create a basic index and index policy

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.13 |
| <a name="requirement_archive"></a> [archive](#requirement\_archive) | = 2.0.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | = 3.72.0 |
| <a name="requirement_elasticsearch"></a> [elasticsearch](#requirement\_elasticsearch) | = 2.0.0-beta.2 |
| <a name="requirement_random"></a> [random](#requirement\_random) | = 3.0.1 |
| <a name="requirement_time"></a> [time](#requirement\_time) | 0.7.2 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 3.72.0 |
| <a name="provider_elasticsearch"></a> [elasticsearch](#provider\_elasticsearch) | 2.0.0-beta.2 |
| <a name="provider_random"></a> [random](#provider\_random) | 3.0.1 |
| <a name="provider_template"></a> [template](#provider\_template) | 2.2.0 |
| <a name="provider_time"></a> [time](#provider\_time) | 0.7.2 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_cloudwatch_log_resource_policy.elasticsearch_logs_policy](https://registry.terraform.io/providers/hashicorp/aws/3.72.0/docs/resources/cloudwatch_log_resource_policy) | resource |
| [aws_elasticsearch_domain.es](https://registry.terraform.io/providers/hashicorp/aws/3.72.0/docs/resources/elasticsearch_domain) | resource |
| [aws_route53_record.elasticsearch](https://registry.terraform.io/providers/hashicorp/aws/3.72.0/docs/resources/route53_record) | resource |
| [aws_security_group_rule.elasticsearch_egress_to_vpc](https://registry.terraform.io/providers/hashicorp/aws/3.72.0/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.elasticsearch_ingress_from_vpc](https://registry.terraform.io/providers/hashicorp/aws/3.72.0/docs/resources/security_group_rule) | resource |
| [aws_ssm_parameter.es_password](https://registry.terraform.io/providers/hashicorp/aws/3.72.0/docs/resources/ssm_parameter) | resource |
| [aws_ssm_parameter.es_user](https://registry.terraform.io/providers/hashicorp/aws/3.72.0/docs/resources/ssm_parameter) | resource |
| [elasticsearch_kibana_object.cloudwatch_index_pattern](https://registry.terraform.io/providers/phillbaker/elasticsearch/2.0.0-beta.2/docs/resources/kibana_object) | resource |
| [elasticsearch_opendistro_ism_policy.prune_indices_after_n_days](https://registry.terraform.io/providers/phillbaker/elasticsearch/2.0.0-beta.2/docs/resources/opendistro_ism_policy) | resource |
| [elasticsearch_opendistro_role.writer](https://registry.terraform.io/providers/phillbaker/elasticsearch/2.0.0-beta.2/docs/resources/opendistro_role) | resource |
| [random_password.es](https://registry.terraform.io/providers/hashicorp/random/3.0.1/docs/resources/password) | resource |
| [time_sleep.wait_for_log_group](https://registry.terraform.io/providers/hashicorp/time/0.7.2/docs/resources/sleep) | resource |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/3.72.0/docs/data-sources/caller_identity) | data source |
| [aws_cloudwatch_log_group.es_log_group](https://registry.terraform.io/providers/hashicorp/aws/3.72.0/docs/data-sources/cloudwatch_log_group) | data source |
| [aws_region.current](https://registry.terraform.io/providers/hashicorp/aws/3.72.0/docs/data-sources/region) | data source |
| [aws_security_group.es](https://registry.terraform.io/providers/hashicorp/aws/3.72.0/docs/data-sources/security_group) | data source |
| [template_file.elasticsearch_access_policy](https://registry.terraform.io/providers/hashicorp/template/latest/docs/data-sources/file) | data source |
| [template_file.opensearch_ism_prune_policy](https://registry.terraform.io/providers/hashicorp/template/latest/docs/data-sources/file) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_admin_allowed_cidr"></a> [admin\_allowed\_cidr](#input\_admin\_allowed\_cidr) | A list of cidrs that are allowed access | `list(string)` | n/a | yes |
| <a name="input_ebs_volume_size"></a> [ebs\_volume\_size](#input\_ebs\_volume\_size) | The size of our ebs instances | `number` | `1500` | no |
| <a name="input_elasticsearch_log_group"></a> [elasticsearch\_log\_group](#input\_elasticsearch\_log\_group) | Our elasticsearch log group | `any` | n/a | yes |
| <a name="input_elasticsearch_log_groups"></a> [elasticsearch\_log\_groups](#input\_elasticsearch\_log\_groups) | The log groups we are going to consume in elastic search | `map(any)` | n/a | yes |
| <a name="input_instance_type"></a> [instance\_type](#input\_instance\_type) | The elasticsearch instance type we want to use | `string` | `"r5.xlarge.elasticsearch"` | no |
| <a name="input_name"></a> [name](#input\_name) | The name used for our naming prefix | `string` | n/a | yes |
| <a name="input_public_zone_id"></a> [public\_zone\_id](#input\_public\_zone\_id) | The public zone id | `string` | n/a | yes |
| <a name="input_public_zone_name"></a> [public\_zone\_name](#input\_public\_zone\_name) | The public zone name for our friendly url | `string` | n/a | yes |
| <a name="input_server_certificate_arn"></a> [server\_certificate\_arn](#input\_server\_certificate\_arn) | The arn of our public ssl certificate | `string` | n/a | yes |
| <a name="input_service_subnets"></a> [service\_subnets](#input\_service\_subnets) | A list of allowed subnets | `list(string)` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of tags for our resource | `map(string)` | n/a | yes |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | The id of our VPC | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_elasticsearch_fqdn"></a> [elasticsearch\_fqdn](#output\_elasticsearch\_fqdn) | The public fqdn for ElasticSearch |
| <a name="output_elasticsearch_password_ssm_name"></a> [elasticsearch\_password\_ssm\_name](#output\_elasticsearch\_password\_ssm\_name) | The name of our ssm password parameter |
| <a name="output_elasticsearch_user_ssm_name"></a> [elasticsearch\_user\_ssm\_name](#output\_elasticsearch\_user\_ssm\_name) | The name of our ssm user parameter |
| <a name="output_elk_endpoint"></a> [elk\_endpoint](#output\_elk\_endpoint) | The internal fqdn for ElasticSearch |
| <a name="output_elk_kibana_endpoint"></a> [elk\_kibana\_endpoint](#output\_elk\_kibana\_endpoint) | The internal fqdn for Kibana |
<!-- END_TF_DOCS -->
