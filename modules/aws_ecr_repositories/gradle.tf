data "docker_registry_image" "gradle_jdk8" {
  name = "gradle:6.7-jdk8"
}
# Get our image hashes
data "external" "gradle_jdk8_hash" {
  program = ["bash", "${path.module}/scripts/docker_hash.sh"]

  query = {
    image = data.docker_registry_image.gradle_jdk8.name
  }
  depends_on = [docker_image.gradle_jdk8]
}

# tfsec:ignore:aws-ecr-repository-customer-key
resource "aws_ecr_repository" "gradle_jdk8" {
  name                 = "gradle-jdk8"
  image_tag_mutability = "IMMUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }

  tags = var.tags
}

resource "aws_ecr_repository_policy" "allow_codebuild_gradle_jdk8" {
  policy     = file("${path.module}/templates/codebuild_image_policy.json")
  repository = aws_ecr_repository.gradle_jdk8.name
}

resource "docker_image" "gradle_jdk8" {
  name          = data.docker_registry_image.gradle_jdk8.name
  keep_locally  = false
  pull_triggers = [data.docker_registry_image.gradle_jdk8.sha256_digest]
}

resource "null_resource" "tag_and_push_gradle_jdk8" {
  triggers = {
    gradle_jdk8_hash = data.docker_registry_image.gradle_jdk8.sha256_digest
  }

  provisioner "local-exec" {
    interpreter = ["/bin/bash", "-c"]
    command     = <<-EOF
      docker tag ${data.docker_registry_image.gradle_jdk8.name} ${aws_ecr_repository.gradle_jdk8.repository_url}:${data.external.gradle_jdk8_hash.result.short_hash};
      aws ecr get-login-password --region ${data.aws_region.current_region.name} | docker login --username AWS --password-stdin ${aws_ecr_repository.gradle_jdk8.repository_url};
      docker push ${aws_ecr_repository.gradle_jdk8.repository_url}:${data.external.gradle_jdk8_hash.result.short_hash}
    EOF
  }
  depends_on = [docker_image.gradle_jdk8]
}
