data "docker_registry_image" "bash" {
  name = "bash:5.1.4"
}

data "external" "bash_hash" {
  program = ["bash", "${path.module}/scripts/docker_hash.sh"]

  query = {
    image = data.docker_registry_image.bash.name
  }
  depends_on = [docker_image.bash]
}

resource "docker_image" "bash" {
  name = data.docker_registry_image.bash.name

  pull_triggers = [data.docker_registry_image.bash.sha256_digest]
}

resource "null_resource" "tag_and_push_bash" {
  triggers = {
    prometheus_hash = data.docker_registry_image.bash.sha256_digest
  }

  provisioner "local-exec" {
    interpreter = ["/bin/bash", "-c"]
    command     = <<-EOF
      docker tag ${data.docker_registry_image.bash.name} ${aws_ecr_repository.bash.repository_url}:${data.external.bash_hash.result.short_hash};
      aws ecr get-login-password --region ${data.aws_region.current_region.name} | docker login --username AWS --password-stdin ${aws_ecr_repository.bash.repository_url};
      docker push ${aws_ecr_repository.bash.repository_url}:${data.external.bash_hash.result.short_hash}
    EOF
  }
}

# tfsec:ignore:aws-ecr-repository-customer-key
resource "aws_ecr_repository" "bash" {
  name                 = "bash"
  image_tag_mutability = "IMMUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }

  tags = var.tags
}

resource "aws_ecr_repository_policy" "ecr_bash_policy" {
  policy     = data.template_file.shared_docker_image_policy.rendered
  repository = aws_ecr_repository.bash.name
}
