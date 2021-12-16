# tfsec:ignore:aws-ecr-repository-customer-key
resource "aws_ecr_repository" "grafana" {
  name                 = "grafana"
  image_tag_mutability = "IMMUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }

  tags = var.tags
}

resource "aws_ecr_repository_policy" "allow_codebuild_grafana" {
  policy     = data.template_file.shared_docker_image_policy.rendered
  repository = aws_ecr_repository.grafana.name
}
