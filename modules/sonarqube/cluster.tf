resource "aws_ecs_cluster" "sonarqube_cluster" {
  name = "${var.name}-sonar"

  setting {
    name  = "containerInsights"
    value = "enabled"
  }

  tags = var.tags
}
