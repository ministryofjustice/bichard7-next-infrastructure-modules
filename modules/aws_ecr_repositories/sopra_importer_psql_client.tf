data "docker_registry_image" "postgres_client" {
  name = "jbergknoff/postgresql-client"
}

# Get our image hashes
data "external" "postgres_client_hash" {
  program = ["bash", "${path.module}/scripts/docker_hash.sh"]

  query = {
    image = data.docker_registry_image.postgres_client.name
  }
  depends_on = [docker_image.postgres_client]
}

# tfsec:ignore:aws-ecr-repository-customer-key
resource "aws_ecr_repository" "postgres_client" {
  name                 = "postgres-client"
  image_tag_mutability = "IMMUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }

  tags = var.tags
}

resource "aws_ecr_repository_policy" "allow_all_postgres_client" {
  policy     = data.template_file.shared_docker_image_policy.rendered
  repository = aws_ecr_repository.postgres_client.name
}

resource "docker_image" "postgres_client" {
  name          = data.docker_registry_image.postgres_client.name
  keep_locally  = false
  pull_triggers = [data.docker_registry_image.postgres_client.sha256_digest]
}

resource "null_resource" "tag_and_push_postgres_client" {
  triggers = {
    postgres_client_hash = data.docker_registry_image.postgres_client.sha256_digest
  }

  provisioner "local-exec" {
    interpreter = ["/bin/bash", "-c"]
    command     = <<-EOF
      docker tag ${data.docker_registry_image.postgres_client.name} ${aws_ecr_repository.postgres_client.repository_url}:${data.external.postgres_client_hash.result.short_hash};
      aws ecr get-login-password --region ${data.aws_region.current_region.name} | docker login --username AWS --password-stdin ${aws_ecr_repository.postgres_client.repository_url};
      docker push ${aws_ecr_repository.postgres_client.repository_url}:${data.external.postgres_client_hash.result.short_hash}
    EOF
  }
  depends_on = [docker_image.postgres_client]
}
