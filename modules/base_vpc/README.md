# Base VPC

Opinionated model to set up a private vpc with service endpoints

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.13 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | = 3.56.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 3.56.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_vpc"></a> [vpc](#module\_vpc) | terraform-aws-modules/vpc/aws | 3.0.0 |
| <a name="module_vpc_endpoints"></a> [vpc\_endpoints](#module\_vpc\_endpoints) | terraform-aws-modules/vpc/aws//modules/vpc-endpoints | 3.0.0 |

## Resources

| Name | Type |
|------|------|
| [aws_security_group.vpc_endpoints](https://registry.terraform.io/providers/hashicorp/aws/3.56.0/docs/resources/security_group) | resource |
| [aws_security_group_rule.vpc_endpoints_egress](https://registry.terraform.io/providers/hashicorp/aws/3.56.0/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.vpc_endpoints_ingress](https://registry.terraform.io/providers/hashicorp/aws/3.56.0/docs/resources/security_group_rule) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cidr_block"></a> [cidr\_block](#input\_cidr\_block) | The base cidr block | `string` | n/a | yes |
| <a name="input_name_prefix"></a> [name\_prefix](#input\_name\_prefix) | The prefix used in naming things | `string` | n/a | yes |
| <a name="input_region_id"></a> [region\_id](#input\_region\_id) | The current region | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of environment tags | `map(string)` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_private_subnet_cidrs"></a> [private\_subnet\_cidrs](#output\_private\_subnet\_cidrs) | A list of private cidr blocks |
| <a name="output_private_subnet_ids"></a> [private\_subnet\_ids](#output\_private\_subnet\_ids) | A list of private subnets |
| <a name="output_security_group_ids"></a> [security\_group\_ids](#output\_security\_group\_ids) | A map of security group ids |
| <a name="output_vpc_endpoint_dynamodb_prefix_list_id"></a> [vpc\_endpoint\_dynamodb\_prefix\_list\_id](#output\_vpc\_endpoint\_dynamodb\_prefix\_list\_id) | The id for the dynamodb prefix list |
| <a name="output_vpc_endpoint_s3_prefix_list_id"></a> [vpc\_endpoint\_s3\_prefix\_list\_id](#output\_vpc\_endpoint\_s3\_prefix\_list\_id) | The id for the s3 prefix list |
| <a name="output_vpc_endpoints"></a> [vpc\_endpoints](#output\_vpc\_endpoints) | A map of our vpc endpoints |
| <a name="output_vpc_id"></a> [vpc\_id](#output\_vpc\_id) | The vpc id |
<!-- END_TF_DOCS -->
