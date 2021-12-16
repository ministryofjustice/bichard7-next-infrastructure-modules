# tfsec:ignore:aws-ecr-repository-customer-key
resource "aws_ecr_repository" "was" {
  name                 = "bichard7-was"
  image_tag_mutability = "IMMUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }

  tags = var.tags
}

# tfsec:ignore:aws-ecr-repository-customer-key
resource "aws_ecr_repository" "bichard7_liberty" {
  name                 = "bichard7-liberty"
  image_tag_mutability = "IMMUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }

  tags = var.tags
}

# tfsec:ignore:aws-ecr-repository-customer-key
resource "aws_ecr_repository" "was_baseline" {
  name                 = "bichard7-was-baseline"
  image_tag_mutability = "IMMUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }

  tags = var.tags
}

resource "aws_ecr_repository_policy" "ecr_was_policy" {
  policy     = data.template_file.shared_docker_image_policy.rendered
  repository = aws_ecr_repository.was.name
}

resource "aws_ecr_repository_policy" "ecr_was_current_policy" {
  policy     = data.template_file.shared_docker_image_policy.rendered
  repository = aws_ecr_repository.was_baseline.name
}

resource "aws_ecr_repository_policy" "ecr_bichard_liberty_policy" {
  policy     = data.template_file.shared_docker_image_policy.rendered
  repository = aws_ecr_repository.bichard7_liberty.name
}
