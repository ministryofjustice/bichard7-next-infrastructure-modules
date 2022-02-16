resource "grafana_dashboard" "codebuild_dashboard" {
  config_json = file("${path.module}/dashboards/aws-codebuild_rev4.json")
}

resource "grafana_dashboard" "codebuild_status_dashboard" {
  config_json = file("${path.module}/dashboards/codebuild-pass-fail-status.json")
}

resource "grafana_folder" "codebuild_vpc_stats" {
  title = "Codebuild VPC"
}

resource "grafana_dashboard" "codebuild_ecs_stats" {
  config_json = file("${path.module}/dashboards/aws-ecs_rev7.json")
  folder      = grafana_folder.codebuild_vpc_stats.id
}