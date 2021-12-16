locals {
  # This is created as a local as the data source we use doesn't support sha256 sums
  websphere = {
    name          = "ibmcom/websphere-traditional"
    sha256_digest = "sha256:c7f311dd5c6045934670d0f3091e8d3a1f198bb152deb88ed4ae63d36ef2af01"
    short_hash    = "c7f311dd5c6045934670d0f3091e8d3a1f198bb152deb88ed4ae63d36ef2af01"
  }
}

# tfsec:ignore:aws-ecr-repository-customer-key
resource "aws_ecr_repository" "websphere" {
  name                 = "websphere"
  image_tag_mutability = "IMMUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }

  tags = var.tags
}

resource "aws_ecr_repository_policy" "allow_codebuild_websphere" {
  policy     = file("${path.module}/templates/codebuild_image_policy.json")
  repository = aws_ecr_repository.websphere.name
}

resource "docker_image" "websphere" {
  name          = "${local.websphere.name}@${local.websphere.sha256_digest}"
  keep_locally  = false
  pull_triggers = [local.websphere.sha256_digest]
}

resource "null_resource" "tag_and_push_websphere" {
  triggers = {
    websphere_hash = local.websphere.sha256_digest
  }

  provisioner "local-exec" {
    interpreter = ["/bin/bash", "-c"]
    command     = <<-EOF
      docker tag ${local.websphere.name}@${local.websphere.sha256_digest} ${aws_ecr_repository.websphere.repository_url}:${local.websphere.short_hash};
      aws ecr get-login-password --region ${data.aws_region.current_region.name} | docker login --username AWS --password-stdin ${aws_ecr_repository.websphere.repository_url};
      docker push ${aws_ecr_repository.websphere.repository_url}:${local.websphere.short_hash}
    EOF
  }
  depends_on = [docker_image.websphere]
}
