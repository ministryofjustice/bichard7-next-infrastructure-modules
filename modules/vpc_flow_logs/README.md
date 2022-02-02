# VPC Flow Logs

Module to configure VPC flow logs

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.13 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | = 3.72.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 3.72.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_cloudwatch_log_metric_filter.flow_log_metric_filter_denied](https://registry.terraform.io/providers/hashicorp/aws/3.72.0/docs/resources/cloudwatch_log_metric_filter) | resource |
| [aws_cloudwatch_log_metric_filter.flow_log_metric_filter_reject](https://registry.terraform.io/providers/hashicorp/aws/3.72.0/docs/resources/cloudwatch_log_metric_filter) | resource |
| [aws_cloudwatch_metric_alarm.flow_log_denied_alarm](https://registry.terraform.io/providers/hashicorp/aws/3.72.0/docs/resources/cloudwatch_metric_alarm) | resource |
| [aws_cloudwatch_metric_alarm.flow_log_reject_alarm](https://registry.terraform.io/providers/hashicorp/aws/3.72.0/docs/resources/cloudwatch_metric_alarm) | resource |
| [aws_flow_log.vpc_flow_log](https://registry.terraform.io/providers/hashicorp/aws/3.72.0/docs/resources/flow_log) | resource |
| [aws_iam_role.flow_log_role](https://registry.terraform.io/providers/hashicorp/aws/3.72.0/docs/resources/iam_role) | resource |
| [aws_iam_role_policy.flow_log_role_policy](https://registry.terraform.io/providers/hashicorp/aws/3.72.0/docs/resources/iam_role_policy) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_tags"></a> [tags](#input\_tags) | A map of tags to apply to this resource | `map(string)` | n/a | yes |
| <a name="input_vpc_flow_log_group"></a> [vpc\_flow\_log\_group](#input\_vpc\_flow\_log\_group) | The outputs from the creation of our vpc\_flow\_logs log group | `any` | n/a | yes |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | VPC ID to attach to. | `string` | n/a | yes |
| <a name="input_vpc_name"></a> [vpc\_name](#input\_vpc\_name) | The VPC name is used to name the flow log resources. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_flow_log_denied_alarm_arn"></a> [flow\_log\_denied\_alarm\_arn](#output\_flow\_log\_denied\_alarm\_arn) | The ARN of our vpc flow log access denied alarm |
| <a name="output_flow_log_reject_alarm_arn"></a> [flow\_log\_reject\_alarm\_arn](#output\_flow\_log\_reject\_alarm\_arn) | The ARN of our vpc flow log access reject alarm |
<!-- END_TF_DOCS -->
