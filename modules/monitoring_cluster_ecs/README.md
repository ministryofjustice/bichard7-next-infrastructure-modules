# Monitoring Cluster ECS

Provisions a monitoring cluster with the following components
- Grafana
- Prometheus
- Prometheus Cloudwatch Exporter
- Prometheus Alert Manager
- Prometheus Blackbox Exporter

Prometheus alerts are published to slack via SNS and Lambdas. Prometheus data is persisted on EFS, dashboards are provisioned inside the docker image
<!-- BEGIN_TF_DOCS -->
<!-- END_TF_DOCS -->
