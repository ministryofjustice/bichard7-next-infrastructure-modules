# tfsec:ignore:aws-ecr-repository-customer-key
resource "aws_ecr_repository" "logstash_7_10_1_staged" {
  name                 = "logstash"
  image_tag_mutability = "IMMUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }

  tags = var.tags
}

resource "aws_ecr_repository_policy" "logstash_7_10_1_staged" {
  policy     = data.template_file.shared_docker_image_policy.rendered
  repository = aws_ecr_repository.logstash_7_10_1_staged.name
}
