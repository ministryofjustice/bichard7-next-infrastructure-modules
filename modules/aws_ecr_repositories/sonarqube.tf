# Ubuntu Focal
data "docker_registry_image" "sonarqube_8_8" {
  name = "sonarqube:8.8-community"
}
# Get our image hashes
data "external" "sonarqube_8_8_hash" {
  program = ["bash", "${path.module}/scripts/docker_hash.sh"]

  query = {
    image = data.docker_registry_image.sonarqube_8_8.name
  }
  depends_on = [docker_image.sonarqube_8_8]
}

# tfsec:ignore:aws-ecr-repository-customer-key
resource "aws_ecr_repository" "sonarqube_8_8" {
  name                 = "sonarqube-8-8"
  image_tag_mutability = "IMMUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }

  tags = var.tags
}

resource "aws_ecr_repository_policy" "allow_sonarqube" {
  policy     = file("${path.module}/templates/codebuild_image_policy.json")
  repository = aws_ecr_repository.sonarqube_8_8.name
}

resource "docker_image" "sonarqube_8_8" {
  name          = data.docker_registry_image.sonarqube_8_8.name
  keep_locally  = false
  pull_triggers = [data.docker_registry_image.sonarqube_8_8.sha256_digest]
}

resource "null_resource" "tag_and_push_sonarqube_8_8" {
  triggers = {
    sonarqube_8_8_hash = data.docker_registry_image.sonarqube_8_8.sha256_digest
  }

  provisioner "local-exec" {
    interpreter = ["/bin/bash", "-c"]
    command     = <<-EOF
      docker tag ${data.docker_registry_image.sonarqube_8_8.name} ${aws_ecr_repository.sonarqube_8_8.repository_url}:${data.external.sonarqube_8_8_hash.result.short_hash};
      aws ecr get-login-password --region ${data.aws_region.current_region.name} | docker login --username AWS --password-stdin ${aws_ecr_repository.sonarqube_8_8.repository_url};
      docker push ${aws_ecr_repository.sonarqube_8_8.repository_url}:${data.external.sonarqube_8_8_hash.result.short_hash}
    EOF
  }
  depends_on = [docker_image.sonarqube_8_8]
}


resource "aws_ecr_lifecycle_policy" "sonarqube_8_8" {
  policy     = file("${path.module}/policies/builder_image_ecr_lifecycle_policy.json")
  repository = aws_ecr_repository.sonarqube_8_8.name
}
