# tfsec:ignore:aws-ecr-repository-customer-key
resource "aws_ecr_repository" "nginx_scan_portal" {
  name                 = "nginx-scan-portal"
  image_tag_mutability = "IMMUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }

  tags = var.tags
}

resource "aws_ecr_repository_policy" "allow_codebuild_nginx_scan_portal" {
  policy     = file("${path.module}/templates/codebuild_image_policy.json")
  repository = aws_ecr_repository.nginx_scan_portal.name
}

# tfsec:ignore:aws-ecr-repository-customer-key
resource "aws_ecr_repository" "nginx_java_supervisord" {
  name                 = "nginx-java-supervisord"
  image_tag_mutability = "IMMUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }

  tags = var.tags
}

resource "aws_ecr_repository_policy" "allow_codebuild_nginx_java_supervisord" {
  policy     = file("${path.module}/templates/codebuild_image_policy.json")
  repository = aws_ecr_repository.nginx_java_supervisord.name
}

# tfsec:ignore:aws-ecr-repository-customer-key
resource "aws_ecr_repository" "nginx_nodejs_supervisord" {
  name                 = "nginx-nodejs-supervisord"
  image_tag_mutability = "IMMUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }

  tags = var.tags
}

resource "aws_ecr_repository_policy" "allow_codebuild_nginx_nodejs_supervisord" {
  policy     = file("${path.module}/templates/codebuild_image_policy.json")
  repository = aws_ecr_repository.nginx_nodejs_supervisord.name
}

# tfsec:ignore:aws-ecr-repository-customer-key
resource "aws_ecr_repository" "nginx_supervisord" {
  name                 = "nginx-supervisord"
  image_tag_mutability = "IMMUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }

  tags = var.tags
}

resource "aws_ecr_repository_policy" "allow_codebuild_nginx_supervisord" {
  policy     = data.template_file.shared_docker_image_policy.rendered
  repository = aws_ecr_repository.nginx_supervisord.name
}
