data "docker_registry_image" "node_alpine_current" {
  name = "node:current-alpine"
}

# Get our image hashes
data "external" "node_alpine_current_hash" {
  program = ["bash", "${path.module}/scripts/docker_hash.sh"]

  query = {
    image = data.docker_registry_image.node_alpine_current.name
  }
  depends_on = [docker_image.node_alpine_current]
}

# tfsec:ignore:aws-ecr-repository-customer-key
resource "aws_ecr_repository" "node_alpine_current" {
  name                 = "node-alpine-current"
  image_tag_mutability = "IMMUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }

  tags = var.tags
}

resource "aws_ecr_repository_policy" "allow_all_node_alpine_current" {
  policy     = data.template_file.shared_docker_image_policy.rendered
  repository = aws_ecr_repository.node_alpine_current.name
}

resource "docker_image" "node_alpine_current" {
  name          = data.docker_registry_image.node_alpine_current.name
  keep_locally  = false
  pull_triggers = [data.docker_registry_image.node_alpine_current.sha256_digest]
}

resource "null_resource" "tag_and_push_node_alpine_current" {
  triggers = {
    node_alpine_current_hash = data.docker_registry_image.node_alpine_current.sha256_digest
  }

  provisioner "local-exec" {
    interpreter = ["/bin/bash", "-c"]
    command     = <<-EOF
      docker tag ${data.docker_registry_image.node_alpine_current.name} ${aws_ecr_repository.node_alpine_current.repository_url}:${data.external.node_alpine_current_hash.result.short_hash};
      aws ecr get-login-password --region ${data.aws_region.current_region.name} | docker login --username AWS --password-stdin ${aws_ecr_repository.node_alpine_current.repository_url};
      docker push ${aws_ecr_repository.node_alpine_current.repository_url}:${data.external.node_alpine_current_hash.result.short_hash}
    EOF
  }
  depends_on = [docker_image.node_alpine_current]
}
