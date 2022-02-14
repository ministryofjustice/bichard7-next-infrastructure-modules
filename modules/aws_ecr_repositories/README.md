# AWS ECR Repositories


<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.13 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | = 3.72.0 |
| <a name="requirement_docker"></a> [docker](#requirement\_docker) | = 2.15.0 |
| <a name="requirement_external"></a> [external](#requirement\_external) | = 2.1.0 |
| <a name="requirement_local"></a> [local](#requirement\_local) | = 2.0.0 |
| <a name="requirement_null"></a> [null](#requirement\_null) | = 3.0.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 3.72.0 |
| <a name="provider_docker"></a> [docker](#provider\_docker) | 2.15.0 |
| <a name="provider_external"></a> [external](#provider\_external) | 2.1.0 |
| <a name="provider_null"></a> [null](#provider\_null) | 3.0.0 |
| <a name="provider_template"></a> [template](#provider\_template) | 2.2.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_ecr_lifecycle_policy.amazon_linux_2](https://registry.terraform.io/providers/hashicorp/aws/3.72.0/docs/resources/ecr_lifecycle_policy) | resource |
| [aws_ecr_lifecycle_policy.amazon_linux_2_base](https://registry.terraform.io/providers/hashicorp/aws/3.72.0/docs/resources/ecr_lifecycle_policy) | resource |
| [aws_ecr_lifecycle_policy.audit_logging_portal](https://registry.terraform.io/providers/hashicorp/aws/3.72.0/docs/resources/ecr_lifecycle_policy) | resource |
| [aws_ecr_lifecycle_policy.beanconnect](https://registry.terraform.io/providers/hashicorp/aws/3.72.0/docs/resources/ecr_lifecycle_policy) | resource |
| [aws_ecr_lifecycle_policy.bichard7_liberty](https://registry.terraform.io/providers/hashicorp/aws/3.72.0/docs/resources/ecr_lifecycle_policy) | resource |
| [aws_ecr_lifecycle_policy.codebuild_base](https://registry.terraform.io/providers/hashicorp/aws/3.72.0/docs/resources/ecr_lifecycle_policy) | resource |
| [aws_ecr_lifecycle_policy.e2etests](https://registry.terraform.io/providers/hashicorp/aws/3.72.0/docs/resources/ecr_lifecycle_policy) | resource |
| [aws_ecr_lifecycle_policy.gradle_jdk11](https://registry.terraform.io/providers/hashicorp/aws/3.72.0/docs/resources/ecr_lifecycle_policy) | resource |
| [aws_ecr_lifecycle_policy.grafana](https://registry.terraform.io/providers/hashicorp/aws/3.72.0/docs/resources/ecr_lifecycle_policy) | resource |
| [aws_ecr_lifecycle_policy.grafana_codebuild](https://registry.terraform.io/providers/hashicorp/aws/3.72.0/docs/resources/ecr_lifecycle_policy) | resource |
| [aws_ecr_lifecycle_policy.liberty](https://registry.terraform.io/providers/hashicorp/aws/3.72.0/docs/resources/ecr_lifecycle_policy) | resource |
| [aws_ecr_lifecycle_policy.liquibase](https://registry.terraform.io/providers/hashicorp/aws/3.72.0/docs/resources/ecr_lifecycle_policy) | resource |
| [aws_ecr_lifecycle_policy.logstash](https://registry.terraform.io/providers/hashicorp/aws/3.72.0/docs/resources/ecr_lifecycle_policy) | resource |
| [aws_ecr_lifecycle_policy.nginx_auth_proxy](https://registry.terraform.io/providers/hashicorp/aws/3.72.0/docs/resources/ecr_lifecycle_policy) | resource |
| [aws_ecr_lifecycle_policy.nginx_java_supervisord](https://registry.terraform.io/providers/hashicorp/aws/3.72.0/docs/resources/ecr_lifecycle_policy) | resource |
| [aws_ecr_lifecycle_policy.nginx_node_js_supervisord](https://registry.terraform.io/providers/hashicorp/aws/3.72.0/docs/resources/ecr_lifecycle_policy) | resource |
| [aws_ecr_lifecycle_policy.nginx_scan_portal](https://registry.terraform.io/providers/hashicorp/aws/3.72.0/docs/resources/ecr_lifecycle_policy) | resource |
| [aws_ecr_lifecycle_policy.nginx_supervisord](https://registry.terraform.io/providers/hashicorp/aws/3.72.0/docs/resources/ecr_lifecycle_policy) | resource |
| [aws_ecr_lifecycle_policy.nodejs](https://registry.terraform.io/providers/hashicorp/aws/3.72.0/docs/resources/ecr_lifecycle_policy) | resource |
| [aws_ecr_lifecycle_policy.openjdk_jre](https://registry.terraform.io/providers/hashicorp/aws/3.72.0/docs/resources/ecr_lifecycle_policy) | resource |
| [aws_ecr_lifecycle_policy.pncemulator](https://registry.terraform.io/providers/hashicorp/aws/3.72.0/docs/resources/ecr_lifecycle_policy) | resource |
| [aws_ecr_lifecycle_policy.postfix](https://registry.terraform.io/providers/hashicorp/aws/3.72.0/docs/resources/ecr_lifecycle_policy) | resource |
| [aws_ecr_lifecycle_policy.prometheus](https://registry.terraform.io/providers/hashicorp/aws/3.72.0/docs/resources/ecr_lifecycle_policy) | resource |
| [aws_ecr_lifecycle_policy.prometheus_blackbox_exporter](https://registry.terraform.io/providers/hashicorp/aws/3.72.0/docs/resources/ecr_lifecycle_policy) | resource |
| [aws_ecr_lifecycle_policy.puppeteer](https://registry.terraform.io/providers/hashicorp/aws/3.72.0/docs/resources/ecr_lifecycle_policy) | resource |
| [aws_ecr_lifecycle_policy.s3_web_proxy](https://registry.terraform.io/providers/hashicorp/aws/3.72.0/docs/resources/ecr_lifecycle_policy) | resource |
| [aws_ecr_lifecycle_policy.scoutsuite](https://registry.terraform.io/providers/hashicorp/aws/3.72.0/docs/resources/ecr_lifecycle_policy) | resource |
| [aws_ecr_lifecycle_policy.sonarqube_8_8](https://registry.terraform.io/providers/hashicorp/aws/3.72.0/docs/resources/ecr_lifecycle_policy) | resource |
| [aws_ecr_lifecycle_policy.user_service](https://registry.terraform.io/providers/hashicorp/aws/3.72.0/docs/resources/ecr_lifecycle_policy) | resource |
| [aws_ecr_lifecycle_policy.zap_owasp_scanner](https://registry.terraform.io/providers/hashicorp/aws/3.72.0/docs/resources/ecr_lifecycle_policy) | resource |
| [aws_ecr_repository.amazon_linux_2](https://registry.terraform.io/providers/hashicorp/aws/3.72.0/docs/resources/ecr_repository) | resource |
| [aws_ecr_repository.amazon_linux_2_base](https://registry.terraform.io/providers/hashicorp/aws/3.72.0/docs/resources/ecr_repository) | resource |
| [aws_ecr_repository.audit_logging_portal](https://registry.terraform.io/providers/hashicorp/aws/3.72.0/docs/resources/ecr_repository) | resource |
| [aws_ecr_repository.beanconnect](https://registry.terraform.io/providers/hashicorp/aws/3.72.0/docs/resources/ecr_repository) | resource |
| [aws_ecr_repository.bichard7_liberty](https://registry.terraform.io/providers/hashicorp/aws/3.72.0/docs/resources/ecr_repository) | resource |
| [aws_ecr_repository.codebuild_base](https://registry.terraform.io/providers/hashicorp/aws/3.72.0/docs/resources/ecr_repository) | resource |
| [aws_ecr_repository.e2etests](https://registry.terraform.io/providers/hashicorp/aws/3.72.0/docs/resources/ecr_repository) | resource |
| [aws_ecr_repository.gradle_jdk11](https://registry.terraform.io/providers/hashicorp/aws/3.72.0/docs/resources/ecr_repository) | resource |
| [aws_ecr_repository.grafana](https://registry.terraform.io/providers/hashicorp/aws/3.72.0/docs/resources/ecr_repository) | resource |
| [aws_ecr_repository.grafana_codebuild](https://registry.terraform.io/providers/hashicorp/aws/3.72.0/docs/resources/ecr_repository) | resource |
| [aws_ecr_repository.liberty](https://registry.terraform.io/providers/hashicorp/aws/3.72.0/docs/resources/ecr_repository) | resource |
| [aws_ecr_repository.liquibase](https://registry.terraform.io/providers/hashicorp/aws/3.72.0/docs/resources/ecr_repository) | resource |
| [aws_ecr_repository.logstash_7_10_1_staged](https://registry.terraform.io/providers/hashicorp/aws/3.72.0/docs/resources/ecr_repository) | resource |
| [aws_ecr_repository.nginx_auth_proxy](https://registry.terraform.io/providers/hashicorp/aws/3.72.0/docs/resources/ecr_repository) | resource |
| [aws_ecr_repository.nginx_java_supervisord](https://registry.terraform.io/providers/hashicorp/aws/3.72.0/docs/resources/ecr_repository) | resource |
| [aws_ecr_repository.nginx_nodejs_supervisord](https://registry.terraform.io/providers/hashicorp/aws/3.72.0/docs/resources/ecr_repository) | resource |
| [aws_ecr_repository.nginx_scan_portal](https://registry.terraform.io/providers/hashicorp/aws/3.72.0/docs/resources/ecr_repository) | resource |
| [aws_ecr_repository.nginx_supervisord](https://registry.terraform.io/providers/hashicorp/aws/3.72.0/docs/resources/ecr_repository) | resource |
| [aws_ecr_repository.nodejs](https://registry.terraform.io/providers/hashicorp/aws/3.72.0/docs/resources/ecr_repository) | resource |
| [aws_ecr_repository.openjdk_jre](https://registry.terraform.io/providers/hashicorp/aws/3.72.0/docs/resources/ecr_repository) | resource |
| [aws_ecr_repository.pncemulator](https://registry.terraform.io/providers/hashicorp/aws/3.72.0/docs/resources/ecr_repository) | resource |
| [aws_ecr_repository.postfix](https://registry.terraform.io/providers/hashicorp/aws/3.72.0/docs/resources/ecr_repository) | resource |
| [aws_ecr_repository.prometheus](https://registry.terraform.io/providers/hashicorp/aws/3.72.0/docs/resources/ecr_repository) | resource |
| [aws_ecr_repository.prometheus_blackbox_exporter](https://registry.terraform.io/providers/hashicorp/aws/3.72.0/docs/resources/ecr_repository) | resource |
| [aws_ecr_repository.prometheus_cloudwatch_exporter](https://registry.terraform.io/providers/hashicorp/aws/3.72.0/docs/resources/ecr_repository) | resource |
| [aws_ecr_repository.puppeteer](https://registry.terraform.io/providers/hashicorp/aws/3.72.0/docs/resources/ecr_repository) | resource |
| [aws_ecr_repository.s3_web_proxy](https://registry.terraform.io/providers/hashicorp/aws/3.72.0/docs/resources/ecr_repository) | resource |
| [aws_ecr_repository.scoutsuite](https://registry.terraform.io/providers/hashicorp/aws/3.72.0/docs/resources/ecr_repository) | resource |
| [aws_ecr_repository.sonarqube_8_8](https://registry.terraform.io/providers/hashicorp/aws/3.72.0/docs/resources/ecr_repository) | resource |
| [aws_ecr_repository.user_service](https://registry.terraform.io/providers/hashicorp/aws/3.72.0/docs/resources/ecr_repository) | resource |
| [aws_ecr_repository.zap_owasp_scanner](https://registry.terraform.io/providers/hashicorp/aws/3.72.0/docs/resources/ecr_repository) | resource |
| [aws_ecr_repository_policy.allow_codebuild_amazon_linux](https://registry.terraform.io/providers/hashicorp/aws/3.72.0/docs/resources/ecr_repository_policy) | resource |
| [aws_ecr_repository_policy.allow_codebuild_amazon_linux_2_base](https://registry.terraform.io/providers/hashicorp/aws/3.72.0/docs/resources/ecr_repository_policy) | resource |
| [aws_ecr_repository_policy.allow_codebuild_audit_logging_portal](https://registry.terraform.io/providers/hashicorp/aws/3.72.0/docs/resources/ecr_repository_policy) | resource |
| [aws_ecr_repository_policy.allow_codebuild_beanconnect](https://registry.terraform.io/providers/hashicorp/aws/3.72.0/docs/resources/ecr_repository_policy) | resource |
| [aws_ecr_repository_policy.allow_codebuild_codebuild_base](https://registry.terraform.io/providers/hashicorp/aws/3.72.0/docs/resources/ecr_repository_policy) | resource |
| [aws_ecr_repository_policy.allow_codebuild_e2etests](https://registry.terraform.io/providers/hashicorp/aws/3.72.0/docs/resources/ecr_repository_policy) | resource |
| [aws_ecr_repository_policy.allow_codebuild_gradle_jdk11](https://registry.terraform.io/providers/hashicorp/aws/3.72.0/docs/resources/ecr_repository_policy) | resource |
| [aws_ecr_repository_policy.allow_codebuild_grafana](https://registry.terraform.io/providers/hashicorp/aws/3.72.0/docs/resources/ecr_repository_policy) | resource |
| [aws_ecr_repository_policy.allow_codebuild_grafana_codebuild](https://registry.terraform.io/providers/hashicorp/aws/3.72.0/docs/resources/ecr_repository_policy) | resource |
| [aws_ecr_repository_policy.allow_codebuild_liberty](https://registry.terraform.io/providers/hashicorp/aws/3.72.0/docs/resources/ecr_repository_policy) | resource |
| [aws_ecr_repository_policy.allow_codebuild_liquibase](https://registry.terraform.io/providers/hashicorp/aws/3.72.0/docs/resources/ecr_repository_policy) | resource |
| [aws_ecr_repository_policy.allow_codebuild_nginx_auth_proxy](https://registry.terraform.io/providers/hashicorp/aws/3.72.0/docs/resources/ecr_repository_policy) | resource |
| [aws_ecr_repository_policy.allow_codebuild_nginx_java_supervisord](https://registry.terraform.io/providers/hashicorp/aws/3.72.0/docs/resources/ecr_repository_policy) | resource |
| [aws_ecr_repository_policy.allow_codebuild_nginx_nodejs_supervisord](https://registry.terraform.io/providers/hashicorp/aws/3.72.0/docs/resources/ecr_repository_policy) | resource |
| [aws_ecr_repository_policy.allow_codebuild_nginx_scan_portal](https://registry.terraform.io/providers/hashicorp/aws/3.72.0/docs/resources/ecr_repository_policy) | resource |
| [aws_ecr_repository_policy.allow_codebuild_nginx_supervisord](https://registry.terraform.io/providers/hashicorp/aws/3.72.0/docs/resources/ecr_repository_policy) | resource |
| [aws_ecr_repository_policy.allow_codebuild_nodejs](https://registry.terraform.io/providers/hashicorp/aws/3.72.0/docs/resources/ecr_repository_policy) | resource |
| [aws_ecr_repository_policy.allow_codebuild_openjdk_jre](https://registry.terraform.io/providers/hashicorp/aws/3.72.0/docs/resources/ecr_repository_policy) | resource |
| [aws_ecr_repository_policy.allow_codebuild_pncemulator](https://registry.terraform.io/providers/hashicorp/aws/3.72.0/docs/resources/ecr_repository_policy) | resource |
| [aws_ecr_repository_policy.allow_codebuild_postfix](https://registry.terraform.io/providers/hashicorp/aws/3.72.0/docs/resources/ecr_repository_policy) | resource |
| [aws_ecr_repository_policy.allow_codebuild_puppeteer](https://registry.terraform.io/providers/hashicorp/aws/3.72.0/docs/resources/ecr_repository_policy) | resource |
| [aws_ecr_repository_policy.allow_codebuild_s3_web_proxy](https://registry.terraform.io/providers/hashicorp/aws/3.72.0/docs/resources/ecr_repository_policy) | resource |
| [aws_ecr_repository_policy.allow_codebuild_scoutsuite](https://registry.terraform.io/providers/hashicorp/aws/3.72.0/docs/resources/ecr_repository_policy) | resource |
| [aws_ecr_repository_policy.allow_codebuild_user_service](https://registry.terraform.io/providers/hashicorp/aws/3.72.0/docs/resources/ecr_repository_policy) | resource |
| [aws_ecr_repository_policy.allow_codebuild_zap_owasp_scanner](https://registry.terraform.io/providers/hashicorp/aws/3.72.0/docs/resources/ecr_repository_policy) | resource |
| [aws_ecr_repository_policy.allow_sonarqube](https://registry.terraform.io/providers/hashicorp/aws/3.72.0/docs/resources/ecr_repository_policy) | resource |
| [aws_ecr_repository_policy.ecr_bichard_liberty_policy](https://registry.terraform.io/providers/hashicorp/aws/3.72.0/docs/resources/ecr_repository_policy) | resource |
| [aws_ecr_repository_policy.ecr_prometheus_cloudwatch_exporter_policy](https://registry.terraform.io/providers/hashicorp/aws/3.72.0/docs/resources/ecr_repository_policy) | resource |
| [aws_ecr_repository_policy.ecr_prometheus_policy](https://registry.terraform.io/providers/hashicorp/aws/3.72.0/docs/resources/ecr_repository_policy) | resource |
| [aws_ecr_repository_policy.logstash_7_10_1_staged](https://registry.terraform.io/providers/hashicorp/aws/3.72.0/docs/resources/ecr_repository_policy) | resource |
| [aws_ecr_repository_policy.prometheus_blackbox_exporter](https://registry.terraform.io/providers/hashicorp/aws/3.72.0/docs/resources/ecr_repository_policy) | resource |
| [docker_image.amazon_linux_2](https://registry.terraform.io/providers/kreuzwerker/docker/2.15.0/docs/resources/image) | resource |
| [docker_image.gradle_jdk11](https://registry.terraform.io/providers/kreuzwerker/docker/2.15.0/docs/resources/image) | resource |
| [docker_image.liberty](https://registry.terraform.io/providers/kreuzwerker/docker/2.15.0/docs/resources/image) | resource |
| [docker_image.liquibase](https://registry.terraform.io/providers/kreuzwerker/docker/2.15.0/docs/resources/image) | resource |
| [docker_image.puppeteer](https://registry.terraform.io/providers/kreuzwerker/docker/2.15.0/docs/resources/image) | resource |
| [docker_image.scoutsuite](https://registry.terraform.io/providers/kreuzwerker/docker/2.15.0/docs/resources/image) | resource |
| [docker_image.sonarqube_8_8](https://registry.terraform.io/providers/kreuzwerker/docker/2.15.0/docs/resources/image) | resource |
| [docker_image.zap_owasp_scanner](https://registry.terraform.io/providers/kreuzwerker/docker/2.15.0/docs/resources/image) | resource |
| [null_resource.tag_and_push_amazon_linux_2](https://registry.terraform.io/providers/hashicorp/null/3.0.0/docs/resources/resource) | resource |
| [null_resource.tag_and_push_gradle_jdk11](https://registry.terraform.io/providers/hashicorp/null/3.0.0/docs/resources/resource) | resource |
| [null_resource.tag_and_push_liberty](https://registry.terraform.io/providers/hashicorp/null/3.0.0/docs/resources/resource) | resource |
| [null_resource.tag_and_push_liquibase](https://registry.terraform.io/providers/hashicorp/null/3.0.0/docs/resources/resource) | resource |
| [null_resource.tag_and_push_puppeteer](https://registry.terraform.io/providers/hashicorp/null/3.0.0/docs/resources/resource) | resource |
| [null_resource.tag_and_push_scoutsuite](https://registry.terraform.io/providers/hashicorp/null/3.0.0/docs/resources/resource) | resource |
| [null_resource.tag_and_push_sonarqube_8_8](https://registry.terraform.io/providers/hashicorp/null/3.0.0/docs/resources/resource) | resource |
| [null_resource.tag_and_push_zap_owasp_scanner](https://registry.terraform.io/providers/hashicorp/null/3.0.0/docs/resources/resource) | resource |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/3.72.0/docs/data-sources/caller_identity) | data source |
| [aws_region.current_region](https://registry.terraform.io/providers/hashicorp/aws/3.72.0/docs/data-sources/region) | data source |
| [docker_registry_image.amazon_linux_2](https://registry.terraform.io/providers/kreuzwerker/docker/2.15.0/docs/data-sources/registry_image) | data source |
| [docker_registry_image.gradle_jdk11](https://registry.terraform.io/providers/kreuzwerker/docker/2.15.0/docs/data-sources/registry_image) | data source |
| [docker_registry_image.liberty](https://registry.terraform.io/providers/kreuzwerker/docker/2.15.0/docs/data-sources/registry_image) | data source |
| [docker_registry_image.liquibase](https://registry.terraform.io/providers/kreuzwerker/docker/2.15.0/docs/data-sources/registry_image) | data source |
| [docker_registry_image.puppeteer](https://registry.terraform.io/providers/kreuzwerker/docker/2.15.0/docs/data-sources/registry_image) | data source |
| [docker_registry_image.scoutsuite](https://registry.terraform.io/providers/kreuzwerker/docker/2.15.0/docs/data-sources/registry_image) | data source |
| [docker_registry_image.sonarqube_8_8](https://registry.terraform.io/providers/kreuzwerker/docker/2.15.0/docs/data-sources/registry_image) | data source |
| [docker_registry_image.zap_owasp_scanner](https://registry.terraform.io/providers/kreuzwerker/docker/2.15.0/docs/data-sources/registry_image) | data source |
| [external_external.amazon_linux_2_hash](https://registry.terraform.io/providers/hashicorp/external/2.1.0/docs/data-sources/external) | data source |
| [external_external.gradle_jdk11_hash](https://registry.terraform.io/providers/hashicorp/external/2.1.0/docs/data-sources/external) | data source |
| [external_external.liberty_hash](https://registry.terraform.io/providers/hashicorp/external/2.1.0/docs/data-sources/external) | data source |
| [external_external.liquibase_hash](https://registry.terraform.io/providers/hashicorp/external/2.1.0/docs/data-sources/external) | data source |
| [external_external.puppeteer_hash](https://registry.terraform.io/providers/hashicorp/external/2.1.0/docs/data-sources/external) | data source |
| [external_external.scoutsuite_hash](https://registry.terraform.io/providers/hashicorp/external/2.1.0/docs/data-sources/external) | data source |
| [external_external.sonarqube_8_8_hash](https://registry.terraform.io/providers/hashicorp/external/2.1.0/docs/data-sources/external) | data source |
| [external_external.zap_owasp_scanner_hash](https://registry.terraform.io/providers/hashicorp/external/2.1.0/docs/data-sources/external) | data source |
| [template_file.shared_docker_image_policy](https://registry.terraform.io/providers/hashicorp/template/latest/docs/data-sources/file) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_child_account_ids"></a> [child\_account\_ids](#input\_child\_account\_ids) | A list of child account id's allowed access to specific docker repos | `list(string)` | `[]` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of resource tags | `map(string)` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_amazon_linux_2_base_arn"></a> [amazon\_linux\_2\_base\_arn](#output\_amazon\_linux\_2\_base\_arn) | The repository arn for amazon-linux2-base image |
| <a name="output_amazon_linux_2_docker_image"></a> [amazon\_linux\_2\_docker\_image](#output\_amazon\_linux\_2\_docker\_image) | The image hash for our ecs deployment |
| <a name="output_amazon_linux_2_repository_arn"></a> [amazon\_linux\_2\_repository\_arn](#output\_amazon\_linux\_2\_repository\_arn) | The repository arn for our amazonlinux 2 image |
| <a name="output_amazon_linux_2_repository_url"></a> [amazon\_linux\_2\_repository\_url](#output\_amazon\_linux\_2\_repository\_url) | The repository url for our amazonlinux 2 image |
| <a name="output_audit_logging_portal"></a> [audit\_logging\_portal](#output\_audit\_logging\_portal) | The outputs of the audit logging portal ecr repository |
| <a name="output_audit_logging_portal_arn"></a> [audit\_logging\_portal\_arn](#output\_audit\_logging\_portal\_arn) | The repository arn for our audit logging portal image |
| <a name="output_bichard_liberty_ecr"></a> [bichard\_liberty\_ecr](#output\_bichard\_liberty\_ecr) | The Bichard Liberty ecr repository details |
| <a name="output_codebuild_base"></a> [codebuild\_base](#output\_codebuild\_base) | The ecr repository for our codebuild image |
| <a name="output_gradle_jdk11_docker_image"></a> [gradle\_jdk11\_docker\_image](#output\_gradle\_jdk11\_docker\_image) | The image hash for our ecs deployment |
| <a name="output_gradle_jdk11_repository_arn"></a> [gradle\_jdk11\_repository\_arn](#output\_gradle\_jdk11\_repository\_arn) | The repository arn for our gradle\_jdk11 image |
| <a name="output_gradle_jdk11_repository_url"></a> [gradle\_jdk11\_repository\_url](#output\_gradle\_jdk11\_repository\_url) | The repository url for our gradle\_jdk11 image |
| <a name="output_grafana_codebuild_repository_arn"></a> [grafana\_codebuild\_repository\_arn](#output\_grafana\_codebuild\_repository\_arn) | The arn of our codebuild grafana repository |
| <a name="output_grafana_repository_arn"></a> [grafana\_repository\_arn](#output\_grafana\_repository\_arn) | The arn of our grafana repository |
| <a name="output_liquibase_docker_image"></a> [liquibase\_docker\_image](#output\_liquibase\_docker\_image) | The image hash for liquibase |
| <a name="output_liquibase_repository_arn"></a> [liquibase\_repository\_arn](#output\_liquibase\_repository\_arn) | The repository arn for our liquibase image |
| <a name="output_logstash_repository_arn"></a> [logstash\_repository\_arn](#output\_logstash\_repository\_arn) | The arn of our logstash repsitory |
| <a name="output_nginx_auth_proxy"></a> [nginx\_auth\_proxy](#output\_nginx\_auth\_proxy) | The outputs for our nginx-auth-proxy image repository |
| <a name="output_nginx_auth_proxy_arn"></a> [nginx\_auth\_proxy\_arn](#output\_nginx\_auth\_proxy\_arn) | The repository ARN for our nginx-auth-proxy image |
| <a name="output_nginx_java_supervisord_arn"></a> [nginx\_java\_supervisord\_arn](#output\_nginx\_java\_supervisord\_arn) | The repository arn for our nginx jre11 supervisord image |
| <a name="output_nginx_nodejs_supervisord_arn"></a> [nginx\_nodejs\_supervisord\_arn](#output\_nginx\_nodejs\_supervisord\_arn) | The repository arn for our nginx nodejs16 supervisord image |
| <a name="output_nginx_scan_portal_repository_arn"></a> [nginx\_scan\_portal\_repository\_arn](#output\_nginx\_scan\_portal\_repository\_arn) | The repository arn for our nginx scan portal image |
| <a name="output_nginx_supervisord_arn"></a> [nginx\_supervisord\_arn](#output\_nginx\_supervisord\_arn) | The repository ARN for our nginx-supervisord image |
| <a name="output_nodejs_repository_arn"></a> [nodejs\_repository\_arn](#output\_nodejs\_repository\_arn) | The repository arn for our nodejs image |
| <a name="output_openjdk_jre_repository_arn"></a> [openjdk\_jre\_repository\_arn](#output\_openjdk\_jre\_repository\_arn) | The repository arn for our openjdk jre image |
| <a name="output_openjdk_jre_repository_url"></a> [openjdk\_jre\_repository\_url](#output\_openjdk\_jre\_repository\_url) | The repository url for our openjdk jre image |
| <a name="output_postfix_ecr"></a> [postfix\_ecr](#output\_postfix\_ecr) | The Postfix ECR repository details |
| <a name="output_prometheus_blackbox_exporter_arn"></a> [prometheus\_blackbox\_exporter\_arn](#output\_prometheus\_blackbox\_exporter\_arn) | The repository arn for our blackbox exporter image |
| <a name="output_prometheus_cloudwatch_exporter_repository_arn"></a> [prometheus\_cloudwatch\_exporter\_repository\_arn](#output\_prometheus\_cloudwatch\_exporter\_repository\_arn) | The repository arn for our prometheus cloudwatch exporter image |
| <a name="output_prometheus_cloudwatch_exporter_repository_url"></a> [prometheus\_cloudwatch\_exporter\_repository\_url](#output\_prometheus\_cloudwatch\_exporter\_repository\_url) | The repository url for our prometheus cloudwatch exporter image |
| <a name="output_prometheus_repository_arn"></a> [prometheus\_repository\_arn](#output\_prometheus\_repository\_arn) | The repository arn for our prometheus image |
| <a name="output_prometheus_repository_url"></a> [prometheus\_repository\_url](#output\_prometheus\_repository\_url) | The repository url for our prometheus image |
| <a name="output_puppeteer_docker_image"></a> [puppeteer\_docker\_image](#output\_puppeteer\_docker\_image) | The image hash for puppeteer |
| <a name="output_puppeteer_repository_arn"></a> [puppeteer\_repository\_arn](#output\_puppeteer\_repository\_arn) | The repository arn for our puppeteer image |
| <a name="output_s3_web_proxy_ecr"></a> [s3\_web\_proxy\_ecr](#output\_s3\_web\_proxy\_ecr) | The S3 Web Proxy ecr repository details |
| <a name="output_scoutsuite_docker_image"></a> [scoutsuite\_docker\_image](#output\_scoutsuite\_docker\_image) | The image hash for our ecs deployment |
| <a name="output_scoutsuite_repository_arn"></a> [scoutsuite\_repository\_arn](#output\_scoutsuite\_repository\_arn) | The repository arn for our scoutsuite image |
| <a name="output_scoutsuite_repository_url"></a> [scoutsuite\_repository\_url](#output\_scoutsuite\_repository\_url) | The repository url for our scoutsuite image |
| <a name="output_sonarqube_8_8_docker_image"></a> [sonarqube\_8\_8\_docker\_image](#output\_sonarqube\_8\_8\_docker\_image) | The image hash for our sonarqube |
| <a name="output_sonarqube_8_8_repository_arn"></a> [sonarqube\_8\_8\_repository\_arn](#output\_sonarqube\_8\_8\_repository\_arn) | The repository arn for our sonarqube image |
| <a name="output_user_service_repository"></a> [user\_service\_repository](#output\_user\_service\_repository) | The outputs of the user service ecr repository |
| <a name="output_user_service_repository_arn"></a> [user\_service\_repository\_arn](#output\_user\_service\_repository\_arn) | The repository arn for our user service image |
| <a name="output_zap_owasp_scanner_docker_image"></a> [zap\_owasp\_scanner\_docker\_image](#output\_zap\_owasp\_scanner\_docker\_image) | The image hash for our ecs deployment |
| <a name="output_zap_owasp_scanner_repository_arn"></a> [zap\_owasp\_scanner\_repository\_arn](#output\_zap\_owasp\_scanner\_repository\_arn) | The repository arn for our zap owasp scanner image |
| <a name="output_zap_owasp_scanner_repository_url"></a> [zap\_owasp\_scanner\_repository\_url](#output\_zap\_owasp\_scanner\_repository\_url) | The repository url for our zap owasp scanner image |
<!-- END_TF_DOCS -->
