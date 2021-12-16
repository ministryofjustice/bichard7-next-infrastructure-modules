data "docker_registry_image" "postgres_12" {
  name = "postgres:12-alpine"
}
# Get our image hashes
data "external" "postgres_12_hash" {
  program = ["bash", "${path.module}/scripts/docker_hash.sh"]

  query = {
    image = data.docker_registry_image.postgres_12.name
  }
  depends_on = [docker_image.postgres_12]
}

# tfsec:ignore:aws-ecr-repository-customer-key
resource "aws_ecr_repository" "postgres_12" {
  name                 = "postgres-12"
  image_tag_mutability = "IMMUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }

  tags = var.tags
}

resource "aws_ecr_repository_policy" "allow_postgres" {
  policy     = file("${path.module}/templates/codebuild_image_policy.json")
  repository = aws_ecr_repository.postgres_12.name
}

resource "docker_image" "postgres_12" {
  name          = data.docker_registry_image.postgres_12.name
  keep_locally  = false
  pull_triggers = [data.docker_registry_image.postgres_12.sha256_digest]
}

resource "null_resource" "tag_and_push_postgres_12" {
  triggers = {
    postgres_12_hash = data.docker_registry_image.postgres_12.sha256_digest
  }

  provisioner "local-exec" {
    interpreter = ["/bin/bash", "-c"]
    command     = <<-EOF
      docker tag ${data.docker_registry_image.postgres_12.name} ${aws_ecr_repository.postgres_12.repository_url}:${data.external.postgres_12_hash.result.short_hash};
      aws ecr get-login-password --region ${data.aws_region.current_region.name} | docker login --username AWS --password-stdin ${aws_ecr_repository.postgres_12.repository_url};
      docker push ${aws_ecr_repository.postgres_12.repository_url}:${data.external.postgres_12_hash.result.short_hash}
    EOF
  }
  depends_on = [docker_image.postgres_12]
}
