# Monitoring Cluster ECS

Provisions a monitoring cluster with the following components

- Grafana
- Prometheus
- Prometheus Cloudwatch Exporter
- Prometheus Alert Manager
- Prometheus Blackbox Exporter

Prometheus alerts are published to slack via SNS and Lambdas. Prometheus data is persisted on EFS, dashboards are provisioned inside the docker image

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
| <a name="provider_archive"></a> [archive](#provider\_archive) | 2.2.0 |
| <a name="provider_aws"></a> [aws](#provider\_aws) | 3.75.2 |
| <a name="provider_random"></a> [random](#provider\_random) | 3.4.3 |
| <a name="provider_template"></a> [template](#provider\_template) | 2.2.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_alb.grafana_alb](https://registry.terraform.io/providers/hashicorp/aws/3.75.2/docs/resources/alb) | resource |
| [aws_alb.logstash_alb](https://registry.terraform.io/providers/hashicorp/aws/3.75.2/docs/resources/alb) | resource |
| [aws_alb.prometheus_alb](https://registry.terraform.io/providers/hashicorp/aws/3.75.2/docs/resources/alb) | resource |
| [aws_alb.prometheus_alert_manager_alb](https://registry.terraform.io/providers/hashicorp/aws/3.75.2/docs/resources/alb) | resource |
| [aws_alb.prometheus_blackbox_exporter_alb](https://registry.terraform.io/providers/hashicorp/aws/3.75.2/docs/resources/alb) | resource |
| [aws_alb.prometheus_cloudwatch_exporter_alb](https://registry.terraform.io/providers/hashicorp/aws/3.75.2/docs/resources/alb) | resource |
| [aws_db_subnet_group.grafana_subnet_group](https://registry.terraform.io/providers/hashicorp/aws/3.75.2/docs/resources/db_subnet_group) | resource |
| [aws_ecs_cluster.monitoring_cluster](https://registry.terraform.io/providers/hashicorp/aws/3.75.2/docs/resources/ecs_cluster) | resource |
| [aws_ecs_service.grafana_ecs_service](https://registry.terraform.io/providers/hashicorp/aws/3.75.2/docs/resources/ecs_service) | resource |
| [aws_ecs_service.logstash_service](https://registry.terraform.io/providers/hashicorp/aws/3.75.2/docs/resources/ecs_service) | resource |
| [aws_ecs_service.prometheus_blackbox_exporter_service](https://registry.terraform.io/providers/hashicorp/aws/3.75.2/docs/resources/ecs_service) | resource |
| [aws_ecs_service.prometheus_cloudwatch_exporter_service](https://registry.terraform.io/providers/hashicorp/aws/3.75.2/docs/resources/ecs_service) | resource |
| [aws_ecs_service.prometheus_service](https://registry.terraform.io/providers/hashicorp/aws/3.75.2/docs/resources/ecs_service) | resource |
| [aws_ecs_task_definition.grafana_ecs_task](https://registry.terraform.io/providers/hashicorp/aws/3.75.2/docs/resources/ecs_task_definition) | resource |
| [aws_ecs_task_definition.logstash_tasks](https://registry.terraform.io/providers/hashicorp/aws/3.75.2/docs/resources/ecs_task_definition) | resource |
| [aws_ecs_task_definition.prometheus_blackbox_exporter_tasks](https://registry.terraform.io/providers/hashicorp/aws/3.75.2/docs/resources/ecs_task_definition) | resource |
| [aws_ecs_task_definition.prometheus_cloudwatch_exporter_tasks](https://registry.terraform.io/providers/hashicorp/aws/3.75.2/docs/resources/ecs_task_definition) | resource |
| [aws_ecs_task_definition.prometheus_tasks](https://registry.terraform.io/providers/hashicorp/aws/3.75.2/docs/resources/ecs_task_definition) | resource |
| [aws_iam_policy.allow_ecs_task_secretsmanager](https://registry.terraform.io/providers/hashicorp/aws/3.75.2/docs/resources/iam_policy) | resource |
| [aws_iam_policy.prometheus_alerts_logging](https://registry.terraform.io/providers/hashicorp/aws/3.75.2/docs/resources/iam_policy) | resource |
| [aws_iam_policy.prometheus_allow_ecr_access](https://registry.terraform.io/providers/hashicorp/aws/3.75.2/docs/resources/iam_policy) | resource |
| [aws_iam_policy.prometheus_allow_sns_publish](https://registry.terraform.io/providers/hashicorp/aws/3.75.2/docs/resources/iam_policy) | resource |
| [aws_iam_policy.prometheus_cloudwatch_ssm](https://registry.terraform.io/providers/hashicorp/aws/3.75.2/docs/resources/iam_policy) | resource |
| [aws_iam_role.prometheus_task_role](https://registry.terraform.io/providers/hashicorp/aws/3.75.2/docs/resources/iam_role) | resource |
| [aws_iam_role.scanning_notification](https://registry.terraform.io/providers/hashicorp/aws/3.75.2/docs/resources/iam_role) | resource |
| [aws_iam_role_policy.allow_admin_role_cmk_access](https://registry.terraform.io/providers/hashicorp/aws/3.75.2/docs/resources/iam_role_policy) | resource |
| [aws_iam_role_policy.allow_prometheus_notifications_kms_access](https://registry.terraform.io/providers/hashicorp/aws/3.75.2/docs/resources/iam_role_policy) | resource |
| [aws_iam_role_policy.allow_ssm_messages](https://registry.terraform.io/providers/hashicorp/aws/3.75.2/docs/resources/iam_role_policy) | resource |
| [aws_iam_role_policy_attachment.attach_cloudwatch_readonly](https://registry.terraform.io/providers/hashicorp/aws/3.75.2/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.attach_ecs_code_deploy_role_for_ecs](https://registry.terraform.io/providers/hashicorp/aws/3.75.2/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.attach_ecs_task_execution](https://registry.terraform.io/providers/hashicorp/aws/3.75.2/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.prometheus_allow_ecr_attachment](https://registry.terraform.io/providers/hashicorp/aws/3.75.2/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.prometheus_allow_secrets_manager](https://registry.terraform.io/providers/hashicorp/aws/3.75.2/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.prometheus_allow_sns_publish](https://registry.terraform.io/providers/hashicorp/aws/3.75.2/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.prometheus_cloudwatch_ssm_attachment](https://registry.terraform.io/providers/hashicorp/aws/3.75.2/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.scanning_lambda_logs](https://registry.terraform.io/providers/hashicorp/aws/3.75.2/docs/resources/iam_role_policy_attachment) | resource |
| [aws_kms_alias.alert_notifications_key_alias](https://registry.terraform.io/providers/hashicorp/aws/3.75.2/docs/resources/kms_alias) | resource |
| [aws_kms_alias.aurora_cluster_encryption_key_alias](https://registry.terraform.io/providers/hashicorp/aws/3.75.2/docs/resources/kms_alias) | resource |
| [aws_kms_alias.cluster_logs_encryption_key](https://registry.terraform.io/providers/hashicorp/aws/3.75.2/docs/resources/kms_alias) | resource |
| [aws_kms_key.alert_notifications_key](https://registry.terraform.io/providers/hashicorp/aws/3.75.2/docs/resources/kms_key) | resource |
| [aws_kms_key.aurora_cluster_encryption_key](https://registry.terraform.io/providers/hashicorp/aws/3.75.2/docs/resources/kms_key) | resource |
| [aws_kms_key.cluster_logs_encryption_key](https://registry.terraform.io/providers/hashicorp/aws/3.75.2/docs/resources/kms_key) | resource |
| [aws_lambda_function.prometheus_alerts](https://registry.terraform.io/providers/hashicorp/aws/3.75.2/docs/resources/lambda_function) | resource |
| [aws_lambda_permission.prometheus_alerts](https://registry.terraform.io/providers/hashicorp/aws/3.75.2/docs/resources/lambda_permission) | resource |
| [aws_lb_listener.grafana_http_listener](https://registry.terraform.io/providers/hashicorp/aws/3.75.2/docs/resources/lb_listener) | resource |
| [aws_lb_listener.grafana_https_listener](https://registry.terraform.io/providers/hashicorp/aws/3.75.2/docs/resources/lb_listener) | resource |
| [aws_lb_listener.logstash_https_listener](https://registry.terraform.io/providers/hashicorp/aws/3.75.2/docs/resources/lb_listener) | resource |
| [aws_lb_listener.prometheus_alert_manager_https_listener](https://registry.terraform.io/providers/hashicorp/aws/3.75.2/docs/resources/lb_listener) | resource |
| [aws_lb_listener.prometheus_blackbox_exporter_https_listener](https://registry.terraform.io/providers/hashicorp/aws/3.75.2/docs/resources/lb_listener) | resource |
| [aws_lb_listener.prometheus_cloudwatch_exporter_https_listener](https://registry.terraform.io/providers/hashicorp/aws/3.75.2/docs/resources/lb_listener) | resource |
| [aws_lb_listener.prometheus_http_listener](https://registry.terraform.io/providers/hashicorp/aws/3.75.2/docs/resources/lb_listener) | resource |
| [aws_lb_listener.prometheus_https_listener](https://registry.terraform.io/providers/hashicorp/aws/3.75.2/docs/resources/lb_listener) | resource |
| [aws_lb_target_group.grafana_alb_target_group](https://registry.terraform.io/providers/hashicorp/aws/3.75.2/docs/resources/lb_target_group) | resource |
| [aws_lb_target_group.logstash_alb](https://registry.terraform.io/providers/hashicorp/aws/3.75.2/docs/resources/lb_target_group) | resource |
| [aws_lb_target_group.prometheus_alb](https://registry.terraform.io/providers/hashicorp/aws/3.75.2/docs/resources/lb_target_group) | resource |
| [aws_lb_target_group.prometheus_alert_manager_alb](https://registry.terraform.io/providers/hashicorp/aws/3.75.2/docs/resources/lb_target_group) | resource |
| [aws_lb_target_group.prometheus_blackbox_exporter_alb](https://registry.terraform.io/providers/hashicorp/aws/3.75.2/docs/resources/lb_target_group) | resource |
| [aws_lb_target_group.prometheus_cloudwatch_exporter_alb](https://registry.terraform.io/providers/hashicorp/aws/3.75.2/docs/resources/lb_target_group) | resource |
| [aws_rds_cluster.grafana_db](https://registry.terraform.io/providers/hashicorp/aws/3.75.2/docs/resources/rds_cluster) | resource |
| [aws_rds_cluster_instance.grafana_db_instance](https://registry.terraform.io/providers/hashicorp/aws/3.75.2/docs/resources/rds_cluster_instance) | resource |
| [aws_route53_record.db_internal](https://registry.terraform.io/providers/hashicorp/aws/3.75.2/docs/resources/route53_record) | resource |
| [aws_route53_record.grafana_public_record](https://registry.terraform.io/providers/hashicorp/aws/3.75.2/docs/resources/route53_record) | resource |
| [aws_route53_record.logstash_private_dns](https://registry.terraform.io/providers/hashicorp/aws/3.75.2/docs/resources/route53_record) | resource |
| [aws_route53_record.prometheus_alert_manager_internal_record](https://registry.terraform.io/providers/hashicorp/aws/3.75.2/docs/resources/route53_record) | resource |
| [aws_route53_record.prometheus_alert_manager_public_record](https://registry.terraform.io/providers/hashicorp/aws/3.75.2/docs/resources/route53_record) | resource |
| [aws_route53_record.prometheus_blackbox_exporter_private_dns](https://registry.terraform.io/providers/hashicorp/aws/3.75.2/docs/resources/route53_record) | resource |
| [aws_route53_record.prometheus_cloudwatch_exporter_private_dns](https://registry.terraform.io/providers/hashicorp/aws/3.75.2/docs/resources/route53_record) | resource |
| [aws_route53_record.prometheus_internal_record](https://registry.terraform.io/providers/hashicorp/aws/3.75.2/docs/resources/route53_record) | resource |
| [aws_route53_record.prometheus_public_record](https://registry.terraform.io/providers/hashicorp/aws/3.75.2/docs/resources/route53_record) | resource |
| [aws_security_group_rule.allow_all_outbound](https://registry.terraform.io/providers/hashicorp/aws/3.75.2/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.allow_all_prometheus_outbound](https://registry.terraform.io/providers/hashicorp/aws/3.75.2/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.allow_audit_logging_bbe_ingress](https://registry.terraform.io/providers/hashicorp/aws/3.75.2/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.allow_bbe_containers_https_egress](https://registry.terraform.io/providers/hashicorp/aws/3.75.2/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.allow_bbe_containers_https_to_vpc](https://registry.terraform.io/providers/hashicorp/aws/3.75.2/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.allow_bbe_containers_pnc_egress](https://registry.terraform.io/providers/hashicorp/aws/3.75.2/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.allow_bbe_egress_to_audit_logging](https://registry.terraform.io/providers/hashicorp/aws/3.75.2/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.allow_bbe_egress_to_bichard7](https://registry.terraform.io/providers/hashicorp/aws/3.75.2/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.allow_bbe_egress_to_bichard7_backend](https://registry.terraform.io/providers/hashicorp/aws/3.75.2/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.allow_bbe_egress_to_user_service](https://registry.terraform.io/providers/hashicorp/aws/3.75.2/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.allow_bichard7_backend_bbe_ingress](https://registry.terraform.io/providers/hashicorp/aws/3.75.2/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.allow_bichard7_bbe_ingress](https://registry.terraform.io/providers/hashicorp/aws/3.75.2/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.allow_black_box_exporter_alb_egress](https://registry.terraform.io/providers/hashicorp/aws/3.75.2/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.allow_elasticsearch_egress_from_logstash](https://registry.terraform.io/providers/hashicorp/aws/3.75.2/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.allow_elasticsearch_ingress_from_logstash](https://registry.terraform.io/providers/hashicorp/aws/3.75.2/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.allow_http_to_alb_from_vpc](https://registry.terraform.io/providers/hashicorp/aws/3.75.2/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.allow_http_to_alert_manager_alb_from_vpc](https://registry.terraform.io/providers/hashicorp/aws/3.75.2/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.allow_https_to_alert_manager_alb_from_vpc](https://registry.terraform.io/providers/hashicorp/aws/3.75.2/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.allow_ingress_to_black_box_exporter_from_alb](https://registry.terraform.io/providers/hashicorp/aws/3.75.2/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.allow_logstash_alb_egress_to_logstash_container](https://registry.terraform.io/providers/hashicorp/aws/3.75.2/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.allow_logstash_alb_ingress_from_vpc](https://registry.terraform.io/providers/hashicorp/aws/3.75.2/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.allow_logstash_alb_ingress_to_logstash](https://registry.terraform.io/providers/hashicorp/aws/3.75.2/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.allow_logstash_egress_to_world](https://registry.terraform.io/providers/hashicorp/aws/3.75.2/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.allow_prometheus_http_alb_egress_from_prometheus](https://registry.terraform.io/providers/hashicorp/aws/3.75.2/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.allow_prometheus_http_alb_ingress_to_prometheus](https://registry.terraform.io/providers/hashicorp/aws/3.75.2/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.allow_user_service_bbe_ingress](https://registry.terraform.io/providers/hashicorp/aws/3.75.2/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.grafana_alb_to_grafana_container](https://registry.terraform.io/providers/hashicorp/aws/3.75.2/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.grafana_alb_to_vpc_https](https://registry.terraform.io/providers/hashicorp/aws/3.75.2/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.grafana_containers_to_db](https://registry.terraform.io/providers/hashicorp/aws/3.75.2/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.grafana_ingress_from_alb](https://registry.terraform.io/providers/hashicorp/aws/3.75.2/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.grafana_to_postgres](https://registry.terraform.io/providers/hashicorp/aws/3.75.2/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.grafana_to_world_https](https://registry.terraform.io/providers/hashicorp/aws/3.75.2/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.nfs_egress_tcp](https://registry.terraform.io/providers/hashicorp/aws/3.75.2/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.nfs_egress_udp](https://registry.terraform.io/providers/hashicorp/aws/3.75.2/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.nfs_ingress_tcp](https://registry.terraform.io/providers/hashicorp/aws/3.75.2/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.nfs_ingress_udp](https://registry.terraform.io/providers/hashicorp/aws/3.75.2/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.nfs_secure_egress_tcp](https://registry.terraform.io/providers/hashicorp/aws/3.75.2/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.nfs_secure_ingress_tcp](https://registry.terraform.io/providers/hashicorp/aws/3.75.2/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.prometheus_alb_allow_https_egress_to_vpc](https://registry.terraform.io/providers/hashicorp/aws/3.75.2/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.prometheus_alb_allow_https_ingress_from_vpc](https://registry.terraform.io/providers/hashicorp/aws/3.75.2/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.prometheus_alb_egress_to_alb](https://registry.terraform.io/providers/hashicorp/aws/3.75.2/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.prometheus_alb_ingress_from_alb](https://registry.terraform.io/providers/hashicorp/aws/3.75.2/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.prometheus_alert_manager_alb_allow_https_egress_to_vpc](https://registry.terraform.io/providers/hashicorp/aws/3.75.2/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.prometheus_alert_manager_alb_egress_from_container](https://registry.terraform.io/providers/hashicorp/aws/3.75.2/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.prometheus_alert_manager_alb_egress_to_container](https://registry.terraform.io/providers/hashicorp/aws/3.75.2/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.prometheus_alert_manager_alb_ingress_from_container](https://registry.terraform.io/providers/hashicorp/aws/3.75.2/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.prometheus_alert_manager_alb_ingress_to_container](https://registry.terraform.io/providers/hashicorp/aws/3.75.2/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.prometheus_cloudwatch_exporter_egress_to_alb](https://registry.terraform.io/providers/hashicorp/aws/3.75.2/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.prometheus_cloudwatch_exporter_ingress_from_alb](https://registry.terraform.io/providers/hashicorp/aws/3.75.2/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.prometheus_cloudwatch_exporter_ingress_to_alb_from_vpc](https://registry.terraform.io/providers/hashicorp/aws/3.75.2/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.prometheus_exporter_scrape_egress_to_prometheus](https://registry.terraform.io/providers/hashicorp/aws/3.75.2/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.prometheus_exporter_scrape_ingress_from_prometheus](https://registry.terraform.io/providers/hashicorp/aws/3.75.2/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.prometheus_nfs_egress_tcp](https://registry.terraform.io/providers/hashicorp/aws/3.75.2/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.prometheus_nfs_egress_udp](https://registry.terraform.io/providers/hashicorp/aws/3.75.2/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.prometheus_nfs_ingress_tcp](https://registry.terraform.io/providers/hashicorp/aws/3.75.2/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.prometheus_nfs_ingress_udp](https://registry.terraform.io/providers/hashicorp/aws/3.75.2/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.prometheus_nfs_secure_egress_tcp](https://registry.terraform.io/providers/hashicorp/aws/3.75.2/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.prometheus_nfs_secure_ingress_tcp](https://registry.terraform.io/providers/hashicorp/aws/3.75.2/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.prometheus_scrape_egress_to_node_exporter](https://registry.terraform.io/providers/hashicorp/aws/3.75.2/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.prometheus_scrape_egress_to_postfix_exporter](https://registry.terraform.io/providers/hashicorp/aws/3.75.2/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.prometheus_scrape_egress_to_prometheus_black_box_exporter](https://registry.terraform.io/providers/hashicorp/aws/3.75.2/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.prometheus_scrape_egress_to_prometheus_exporter](https://registry.terraform.io/providers/hashicorp/aws/3.75.2/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.prometheus_scrape_ingress_to_prometheus_black_box_exporter_alb](https://registry.terraform.io/providers/hashicorp/aws/3.75.2/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.vpc_to_grafana_alb_http](https://registry.terraform.io/providers/hashicorp/aws/3.75.2/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.vpc_to_grafana_alb_https](https://registry.terraform.io/providers/hashicorp/aws/3.75.2/docs/resources/security_group_rule) | resource |
| [aws_sns_topic.alert_notifications](https://registry.terraform.io/providers/hashicorp/aws/3.75.2/docs/resources/sns_topic) | resource |
| [aws_sns_topic_policy.default](https://registry.terraform.io/providers/hashicorp/aws/3.75.2/docs/resources/sns_topic_policy) | resource |
| [aws_sns_topic_subscription.prometheus_alerts_subscription](https://registry.terraform.io/providers/hashicorp/aws/3.75.2/docs/resources/sns_topic_subscription) | resource |
| [aws_ssm_parameter.admin_htaccess_password](https://registry.terraform.io/providers/hashicorp/aws/3.75.2/docs/resources/ssm_parameter) | resource |
| [aws_ssm_parameter.admin_htaccess_username](https://registry.terraform.io/providers/hashicorp/aws/3.75.2/docs/resources/ssm_parameter) | resource |
| [aws_ssm_parameter.grafana_admin_password](https://registry.terraform.io/providers/hashicorp/aws/3.75.2/docs/resources/ssm_parameter) | resource |
| [aws_ssm_parameter.grafana_admin_username](https://registry.terraform.io/providers/hashicorp/aws/3.75.2/docs/resources/ssm_parameter) | resource |
| [aws_ssm_parameter.grafana_db_password](https://registry.terraform.io/providers/hashicorp/aws/3.75.2/docs/resources/ssm_parameter) | resource |
| [aws_ssm_parameter.grafana_db_username](https://registry.terraform.io/providers/hashicorp/aws/3.75.2/docs/resources/ssm_parameter) | resource |
| [aws_ssm_parameter.grafana_secret_key](https://registry.terraform.io/providers/hashicorp/aws/3.75.2/docs/resources/ssm_parameter) | resource |
| [random_password.admin_htaccess_password](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/password) | resource |
| [random_password.grafana_admin_password](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/password) | resource |
| [random_password.grafana_db_password](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/password) | resource |
| [random_string.grafana_admin_suffix](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/string) | resource |
| [random_string.grafana_dbuser](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/string) | resource |
| [random_string.grafana_secret_key](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/string) | resource |
| [archive_file.alert_archive](https://registry.terraform.io/providers/hashicorp/archive/latest/docs/data-sources/file) | data source |
| [aws_availability_zones.current](https://registry.terraform.io/providers/hashicorp/aws/3.75.2/docs/data-sources/availability_zones) | data source |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/3.75.2/docs/data-sources/caller_identity) | data source |
| [aws_cloudwatch_log_group.blackbox_exporter](https://registry.terraform.io/providers/hashicorp/aws/3.75.2/docs/data-sources/cloudwatch_log_group) | data source |
| [aws_cloudwatch_log_group.cloudwatch_exporter](https://registry.terraform.io/providers/hashicorp/aws/3.75.2/docs/data-sources/cloudwatch_log_group) | data source |
| [aws_cloudwatch_log_group.grafana](https://registry.terraform.io/providers/hashicorp/aws/3.75.2/docs/data-sources/cloudwatch_log_group) | data source |
| [aws_cloudwatch_log_group.logstash](https://registry.terraform.io/providers/hashicorp/aws/3.75.2/docs/data-sources/cloudwatch_log_group) | data source |
| [aws_iam_role.admin_role](https://registry.terraform.io/providers/hashicorp/aws/3.75.2/docs/data-sources/iam_role) | data source |
| [aws_kms_key.secret_encryption_key](https://registry.terraform.io/providers/hashicorp/aws/3.75.2/docs/data-sources/kms_key) | data source |
| [aws_lb.audit_logging](https://registry.terraform.io/providers/hashicorp/aws/3.75.2/docs/data-sources/lb) | data source |
| [aws_lb.beanconnect](https://registry.terraform.io/providers/hashicorp/aws/3.75.2/docs/data-sources/lb) | data source |
| [aws_lb.user_service](https://registry.terraform.io/providers/hashicorp/aws/3.75.2/docs/data-sources/lb) | data source |
| [aws_lb_target_group.app](https://registry.terraform.io/providers/hashicorp/aws/3.75.2/docs/data-sources/lb_target_group) | data source |
| [aws_lb_target_group.audit_logging](https://registry.terraform.io/providers/hashicorp/aws/3.75.2/docs/data-sources/lb_target_group) | data source |
| [aws_lb_target_group.beanconnect](https://registry.terraform.io/providers/hashicorp/aws/3.75.2/docs/data-sources/lb_target_group) | data source |
| [aws_lb_target_group.user_service](https://registry.terraform.io/providers/hashicorp/aws/3.75.2/docs/data-sources/lb_target_group) | data source |
| [aws_region.current](https://registry.terraform.io/providers/hashicorp/aws/3.75.2/docs/data-sources/region) | data source |
| [aws_route53_zone.cjse_dot_org](https://registry.terraform.io/providers/hashicorp/aws/3.75.2/docs/data-sources/route53_zone) | data source |
| [aws_secretsmanager_secret.os_password](https://registry.terraform.io/providers/hashicorp/aws/3.75.2/docs/data-sources/secretsmanager_secret) | data source |
| [aws_secretsmanager_secret_version.os_password](https://registry.terraform.io/providers/hashicorp/aws/3.75.2/docs/data-sources/secretsmanager_secret_version) | data source |
| [aws_security_group.audit_logging_portal_alb](https://registry.terraform.io/providers/hashicorp/aws/3.75.2/docs/data-sources/security_group) | data source |
| [aws_security_group.bichard7_alb_backend](https://registry.terraform.io/providers/hashicorp/aws/3.75.2/docs/data-sources/security_group) | data source |
| [aws_security_group.bichard_alb_web](https://registry.terraform.io/providers/hashicorp/aws/3.75.2/docs/data-sources/security_group) | data source |
| [aws_security_group.elasticsearch_security_group](https://registry.terraform.io/providers/hashicorp/aws/3.75.2/docs/data-sources/security_group) | data source |
| [aws_security_group.grafana_alb_security_group](https://registry.terraform.io/providers/hashicorp/aws/3.75.2/docs/data-sources/security_group) | data source |
| [aws_security_group.grafana_db_security_group](https://registry.terraform.io/providers/hashicorp/aws/3.75.2/docs/data-sources/security_group) | data source |
| [aws_security_group.grafana_security_group](https://registry.terraform.io/providers/hashicorp/aws/3.75.2/docs/data-sources/security_group) | data source |
| [aws_security_group.logstash_alb_security_group](https://registry.terraform.io/providers/hashicorp/aws/3.75.2/docs/data-sources/security_group) | data source |
| [aws_security_group.logstash_security_group](https://registry.terraform.io/providers/hashicorp/aws/3.75.2/docs/data-sources/security_group) | data source |
| [aws_security_group.prometheus_alb](https://registry.terraform.io/providers/hashicorp/aws/3.75.2/docs/data-sources/security_group) | data source |
| [aws_security_group.prometheus_alert_manager_alb](https://registry.terraform.io/providers/hashicorp/aws/3.75.2/docs/data-sources/security_group) | data source |
| [aws_security_group.prometheus_blackbox_exporter_alb](https://registry.terraform.io/providers/hashicorp/aws/3.75.2/docs/data-sources/security_group) | data source |
| [aws_security_group.prometheus_blackbox_exporter_security_group](https://registry.terraform.io/providers/hashicorp/aws/3.75.2/docs/data-sources/security_group) | data source |
| [aws_security_group.prometheus_cloudwatch_exporter_alb](https://registry.terraform.io/providers/hashicorp/aws/3.75.2/docs/data-sources/security_group) | data source |
| [aws_security_group.prometheus_exporter_security_group](https://registry.terraform.io/providers/hashicorp/aws/3.75.2/docs/data-sources/security_group) | data source |
| [aws_security_group.prometheus_security_group](https://registry.terraform.io/providers/hashicorp/aws/3.75.2/docs/data-sources/security_group) | data source |
| [aws_security_group.user_service_alb](https://registry.terraform.io/providers/hashicorp/aws/3.75.2/docs/data-sources/security_group) | data source |
| [aws_ssm_parameter.es_username](https://registry.terraform.io/providers/hashicorp/aws/3.75.2/docs/data-sources/ssm_parameter) | data source |
| [template_file.alert_webhook_source](https://registry.terraform.io/providers/hashicorp/template/2.2.0/docs/data-sources/file) | data source |
| [template_file.allow_cmk_admin_access](https://registry.terraform.io/providers/hashicorp/template/2.2.0/docs/data-sources/file) | data source |
| [template_file.allow_ecr_policy](https://registry.terraform.io/providers/hashicorp/template/2.2.0/docs/data-sources/file) | data source |
| [template_file.allow_kms_access](https://registry.terraform.io/providers/hashicorp/template/2.2.0/docs/data-sources/file) | data source |
| [template_file.allow_notifications_kms_access](https://registry.terraform.io/providers/hashicorp/template/2.2.0/docs/data-sources/file) | data source |
| [template_file.allow_sns_events_publish](https://registry.terraform.io/providers/hashicorp/template/2.2.0/docs/data-sources/file) | data source |
| [template_file.allow_sns_publish_policy](https://registry.terraform.io/providers/hashicorp/template/2.2.0/docs/data-sources/file) | data source |
| [template_file.allow_ssm](https://registry.terraform.io/providers/hashicorp/template/2.2.0/docs/data-sources/file) | data source |
| [template_file.allow_ssm_messages](https://registry.terraform.io/providers/hashicorp/template/2.2.0/docs/data-sources/file) | data source |
| [template_file.grafana_ecs_task](https://registry.terraform.io/providers/hashicorp/template/2.2.0/docs/data-sources/file) | data source |
| [template_file.logstash](https://registry.terraform.io/providers/hashicorp/template/2.2.0/docs/data-sources/file) | data source |
| [template_file.prometheus_blackbox_exporter_ecs_task](https://registry.terraform.io/providers/hashicorp/template/2.2.0/docs/data-sources/file) | data source |
| [template_file.prometheus_ecs_task](https://registry.terraform.io/providers/hashicorp/template/2.2.0/docs/data-sources/file) | data source |
| [template_file.prometheus_exporter_ecs_task](https://registry.terraform.io/providers/hashicorp/template/2.2.0/docs/data-sources/file) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_allowed_ingress_cidr"></a> [allowed\_ingress\_cidr](#input\_allowed\_ingress\_cidr) | An allowed list of ingress CIDRS in our vpc | `list(string)` | n/a | yes |
| <a name="input_app_targetgroup_arn"></a> [app\_targetgroup\_arn](#input\_app\_targetgroup\_arn) | The arn of our application target group | `string` | n/a | yes |
| <a name="input_audit_logging_targetgroup_arn"></a> [audit\_logging\_targetgroup\_arn](#input\_audit\_logging\_targetgroup\_arn) | The arn of our audit logging target group | `string` | n/a | yes |
| <a name="input_beanconnect_targetgroup_arn"></a> [beanconnect\_targetgroup\_arn](#input\_beanconnect\_targetgroup\_arn) | The arn of our beanconnect target group | `string` | n/a | yes |
| <a name="input_ecs_to_efs_sg_id"></a> [ecs\_to\_efs\_sg\_id](#input\_ecs\_to\_efs\_sg\_id) | The security group id for our ecs/efs communication | `string` | n/a | yes |
| <a name="input_efs_access_points"></a> [efs\_access\_points](#input\_efs\_access\_points) | A list of efs access points for data storage | `any` | n/a | yes |
| <a name="input_elasticsearch_host"></a> [elasticsearch\_host](#input\_elasticsearch\_host) | The elasticsearch host | `string` | n/a | yes |
| <a name="input_environment"></a> [environment](#input\_environment) | The target environment, will map to the terraform workspace | `string` | n/a | yes |
| <a name="input_fargate_cpu"></a> [fargate\_cpu](#input\_fargate\_cpu) | The number of cpu units | `number` | `1024` | no |
| <a name="input_fargate_memory"></a> [fargate\_memory](#input\_fargate\_memory) | The amount of memory that will be given to fargate in Megabytes | `number` | `2048` | no |
| <a name="input_grafana_db_instance_class"></a> [grafana\_db\_instance\_class](#input\_grafana\_db\_instance\_class) | The class of DB instance we are using for Grafana | `string` | `"db.t4g.medium"` | no |
| <a name="input_grafana_db_instance_count"></a> [grafana\_db\_instance\_count](#input\_grafana\_db\_instance\_count) | The number of DB instance we are using for Grafana | `number` | `3` | no |
| <a name="input_grafana_image"></a> [grafana\_image](#input\_grafana\_image) | The url of our grafana ecs image we want to use | `string` | n/a | yes |
| <a name="input_idle_timeout"></a> [idle\_timeout](#input\_idle\_timeout) | How long in seconds before we terminate a connection | `number` | `180` | no |
| <a name="input_logging_bucket_name"></a> [logging\_bucket\_name](#input\_logging\_bucket\_name) | The default logging bucket for lb access logs | `string` | n/a | yes |
| <a name="input_logstash_image"></a> [logstash\_image](#input\_logstash\_image) | The logstash image we wish to deploy | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | The deployments name | `string` | n/a | yes |
| <a name="input_parent_account_id"></a> [parent\_account\_id](#input\_parent\_account\_id) | The id of the parent account | `string` | `null` | no |
| <a name="input_private_zone_id"></a> [private\_zone\_id](#input\_private\_zone\_id) | The zone id of our privated hosted zone | `string` | n/a | yes |
| <a name="input_prometheus_blackbox_exporter_image"></a> [prometheus\_blackbox\_exporter\_image](#input\_prometheus\_blackbox\_exporter\_image) | The url of our prometheus blackbox exporter image ecs image we want to use | `string` | n/a | yes |
| <a name="input_prometheus_cloudwatch_exporter_image"></a> [prometheus\_cloudwatch\_exporter\_image](#input\_prometheus\_cloudwatch\_exporter\_image) | The ecr image we want to deploy | `string` | n/a | yes |
| <a name="input_prometheus_data_directory"></a> [prometheus\_data\_directory](#input\_prometheus\_data\_directory) | The absolute path where we want to store our Prometheus data | `string` | `"/data"` | no |
| <a name="input_prometheus_data_retention_days"></a> [prometheus\_data\_retention\_days](#input\_prometheus\_data\_retention\_days) | The number of days we want to store our prometheus data for | `string` | `"180"` | no |
| <a name="input_prometheus_efs_filesystem_id"></a> [prometheus\_efs\_filesystem\_id](#input\_prometheus\_efs\_filesystem\_id) | The ECS ID to mount our filessytem | `string` | n/a | yes |
| <a name="input_prometheus_efs_filesystem_path"></a> [prometheus\_efs\_filesystem\_path](#input\_prometheus\_efs\_filesystem\_path) | The ECS ID to mount our filesystem | `string` | `"/data/prometheus"` | no |
| <a name="input_prometheus_image"></a> [prometheus\_image](#input\_prometheus\_image) | The ecr image we want to deploy | `string` | n/a | yes |
| <a name="input_prometheus_log_group"></a> [prometheus\_log\_group](#input\_prometheus\_log\_group) | Our prometheus log group | `any` | n/a | yes |
| <a name="input_public_zone_id"></a> [public\_zone\_id](#input\_public\_zone\_id) | The zone id for our public hosted zone so we can use ACM certificates | `string` | n/a | yes |
| <a name="input_public_zone_name"></a> [public\_zone\_name](#input\_public\_zone\_name) | The zone name fqdn so we can create a public route53 entry | `string` | n/a | yes |
| <a name="input_remote_exec_enabled"></a> [remote\_exec\_enabled](#input\_remote\_exec\_enabled) | Do we want to allow remote-exec onto these containers | `bool` | `true` | no |
| <a name="input_service_subnets"></a> [service\_subnets](#input\_service\_subnets) | A list of our subnets | `list(string)` | n/a | yes |
| <a name="input_slack_channel_name"></a> [slack\_channel\_name](#input\_slack\_channel\_name) | The slack channel we are going to send our alerts to | `string` | `"moj-cjse-bichard-alerts"` | no |
| <a name="input_slack_webhook_url"></a> [slack\_webhook\_url](#input\_slack\_webhook\_url) | The slack webhook url we are using to push our notifications | `string` | n/a | yes |
| <a name="input_ssl_certificate_arn"></a> [ssl\_certificate\_arn](#input\_ssl\_certificate\_arn) | The arn of our ssl certificate | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of environment tags | `map(string)` | `{}` | no |
| <a name="input_user_service_targetgroup_arn"></a> [user\_service\_targetgroup\_arn](#input\_user\_service\_targetgroup\_arn) | The arn of our user service target group | `string` | n/a | yes |
| <a name="input_using_smtp_service"></a> [using\_smtp\_service](#input\_using\_smtp\_service) | Are we using the CJSM smtp service | `bool` | `false` | no |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | The vpc id for our security groups to bind to | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_alert_manager_external_fqdn"></a> [alert\_manager\_external\_fqdn](#output\_alert\_manager\_external\_fqdn) | The public dns record for our prometheus alert manager |
| <a name="output_grafana_external_fqdn"></a> [grafana\_external\_fqdn](#output\_grafana\_external\_fqdn) | The public dns record for our grafana server |
| <a name="output_prometheus_external_fqdn"></a> [prometheus\_external\_fqdn](#output\_prometheus\_external\_fqdn) | The public dns record for our prometheus server |
| <a name="output_prometheus_internal_fqdn"></a> [prometheus\_internal\_fqdn](#output\_prometheus\_internal\_fqdn) | The private dns record for our prometheus server |
<!-- END_TF_DOCS -->
