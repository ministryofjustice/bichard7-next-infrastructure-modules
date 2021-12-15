# ECS Cluster
Opinionated module to create an ecs cluster and associated service. A cluster reference can be passed in to be consumed
and this module can be used to create tasks for it

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

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_cloudwatch_log_stream.log_stream](https://registry.terraform.io/providers/hashicorp/aws/3.56.0/docs/resources/cloudwatch_log_stream) | resource |
| [aws_ecs_cluster.cluster](https://registry.terraform.io/providers/hashicorp/aws/3.56.0/docs/resources/ecs_cluster) | resource |
| [aws_ecs_service.ecs_service](https://registry.terraform.io/providers/hashicorp/aws/3.56.0/docs/resources/ecs_service) | resource |
| [aws_ecs_task_definition.task_definition](https://registry.terraform.io/providers/hashicorp/aws/3.56.0/docs/resources/ecs_task_definition) | resource |
| [aws_iam_role.ecs_service_role](https://registry.terraform.io/providers/hashicorp/aws/3.56.0/docs/resources/iam_role) | resource |
| [aws_iam_role_policy.allow_admin_role_cmk_access](https://registry.terraform.io/providers/hashicorp/aws/3.56.0/docs/resources/iam_role_policy) | resource |
| [aws_iam_role_policy.allow_ecr](https://registry.terraform.io/providers/hashicorp/aws/3.56.0/docs/resources/iam_role_policy) | resource |
| [aws_iam_role_policy.allow_kms](https://registry.terraform.io/providers/hashicorp/aws/3.56.0/docs/resources/iam_role_policy) | resource |
| [aws_iam_role_policy.allow_ssm](https://registry.terraform.io/providers/hashicorp/aws/3.56.0/docs/resources/iam_role_policy) | resource |
| [aws_iam_role_policy.allow_ssm_messages](https://registry.terraform.io/providers/hashicorp/aws/3.56.0/docs/resources/iam_role_policy) | resource |
| [aws_iam_role_policy.allow_ssm_messages_external_kms](https://registry.terraform.io/providers/hashicorp/aws/3.56.0/docs/resources/iam_role_policy) | resource |
| [aws_iam_role_policy_attachment.attach_ecs_code_deploy_role_for_ecs](https://registry.terraform.io/providers/hashicorp/aws/3.56.0/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.attach_ecs_task_execution](https://registry.terraform.io/providers/hashicorp/aws/3.56.0/docs/resources/iam_role_policy_attachment) | resource |
| [aws_kms_alias.cluster_logs_encryption_key](https://registry.terraform.io/providers/hashicorp/aws/3.56.0/docs/resources/kms_alias) | resource |
| [aws_kms_key.cluster_logs_encryption_key](https://registry.terraform.io/providers/hashicorp/aws/3.56.0/docs/resources/kms_key) | resource |
| [aws_availability_zones.this](https://registry.terraform.io/providers/hashicorp/aws/3.56.0/docs/data-sources/availability_zones) | data source |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/3.56.0/docs/data-sources/caller_identity) | data source |
| [aws_ecs_cluster.cluster](https://registry.terraform.io/providers/hashicorp/aws/3.56.0/docs/data-sources/ecs_cluster) | data source |
| [aws_iam_role.admin_role](https://registry.terraform.io/providers/hashicorp/aws/3.56.0/docs/data-sources/iam_role) | data source |
| [aws_region.current](https://registry.terraform.io/providers/hashicorp/aws/3.56.0/docs/data-sources/region) | data source |
| [aws_security_group.cluster_sg](https://registry.terraform.io/providers/hashicorp/aws/3.56.0/docs/data-sources/security_group) | data source |
| [template_file.allow_admin_cmk_access](https://registry.terraform.io/providers/hashicorp/template/2.2.0/docs/data-sources/file) | data source |
| [template_file.allow_ecr_repository](https://registry.terraform.io/providers/hashicorp/template/2.2.0/docs/data-sources/file) | data source |
| [template_file.allow_kms_usage](https://registry.terraform.io/providers/hashicorp/template/2.2.0/docs/data-sources/file) | data source |
| [template_file.allow_ssm_messages](https://registry.terraform.io/providers/hashicorp/template/2.2.0/docs/data-sources/file) | data source |
| [template_file.allow_ssm_messages_external_kms](https://registry.terraform.io/providers/hashicorp/template/2.2.0/docs/data-sources/file) | data source |
| [template_file.allow_ssm_parameters](https://registry.terraform.io/providers/hashicorp/template/2.2.0/docs/data-sources/file) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_assign_public_ip"></a> [assign\_public\_ip](#input\_assign\_public\_ip) | Do we assign a public ip to our containers | `bool` | `false` | no |
| <a name="input_cluster_name"></a> [cluster\_name](#input\_cluster\_name) | The name of our resource | `string` | n/a | yes |
| <a name="input_container_count"></a> [container\_count](#input\_container\_count) | The number of containers we require, defaults to one per AZ | `number` | `null` | no |
| <a name="input_create_cluster"></a> [create\_cluster](#input\_create\_cluster) | Are we creating the cluster | `bool` | `true` | no |
| <a name="input_ecr_repository_arns"></a> [ecr\_repository\_arns](#input\_ecr\_repository\_arns) | A list of ecr repository arns we are allowed access to | `list(string)` | n/a | yes |
| <a name="input_efs_volume_configuration"></a> [efs\_volume\_configuration](#input\_efs\_volume\_configuration) | n/a | `any` | `[]` | no |
| <a name="input_enable_execute_command"></a> [enable\_execute\_command](#input\_enable\_execute\_command) | Allow us to exec into a container | `bool` | `false` | no |
| <a name="input_fargate_cpu"></a> [fargate\_cpu](#input\_fargate\_cpu) | The number of cpu units this task has | `number` | `1024` | no |
| <a name="input_fargate_memory"></a> [fargate\_memory](#input\_fargate\_memory) | The number of memory units this task has | `number` | `4096` | no |
| <a name="input_load_balancers"></a> [load\_balancers](#input\_load\_balancers) | A map of maps of load balancer configurations | `list(map(string))` | `[]` | no |
| <a name="input_log_group_name"></a> [log\_group\_name](#input\_log\_group\_name) | The name of the log group we are publishing to | `string` | n/a | yes |
| <a name="input_logging_bucket_name"></a> [logging\_bucket\_name](#input\_logging\_bucket\_name) | The name of our s3 logging bucket, only required if we are enabling ecs exec | `string` | `null` | no |
| <a name="input_remote_cluster_kms_key_arn"></a> [remote\_cluster\_kms\_key\_arn](#input\_remote\_cluster\_kms\_key\_arn) | If we are using an externally created cluster and want to use execute command we need to pass in the kms key arn | `string` | `null` | no |
| <a name="input_rendered_task_definition"></a> [rendered\_task\_definition](#input\_rendered\_task\_definition) | The rendered task definition file base64 encoded | `string` | n/a | yes |
| <a name="input_security_group_name"></a> [security\_group\_name](#input\_security\_group\_name) | The name of the security group used on the cluster | `string` | n/a | yes |
| <a name="input_service_name"></a> [service\_name](#input\_service\_name) | The name of the service in the cluster | `string` | `null` | no |
| <a name="input_service_subnets"></a> [service\_subnets](#input\_service\_subnets) | A list of subnets this load balancer will connect to | `list(string)` | n/a | yes |
| <a name="input_ssm_resources"></a> [ssm\_resources](#input\_ssm\_resources) | A list of ssm resources we can access | `list(string)` | `[]` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of tags for our resource | `map(string)` | n/a | yes |
| <a name="input_volumes"></a> [volumes](#input\_volumes) | A list of volumes that we will attach to the container | `any` | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_ecs_cluster"></a> [ecs\_cluster](#output\_ecs\_cluster) | The ecs cluster outputs |
| <a name="output_ecs_service"></a> [ecs\_service](#output\_ecs\_service) | The outputs of the ecs service |
| <a name="output_ecs_service_role"></a> [ecs\_service\_role](#output\_ecs\_service\_role) | The outputs of the service role |
| <a name="output_ecs_task"></a> [ecs\_task](#output\_ecs\_task) | The ecs task outputs |
<!-- END_TF_DOCS -->
