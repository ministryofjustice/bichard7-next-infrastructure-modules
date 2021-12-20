data "aws_region" "current" {}

data "aws_caller_identity" "current" {}

data "template_file" "sonarqube_ecs_task" {
  template = file("${path.module}/templates/sonarqube_setup_task.json.tpl")

  vars = {
    sonarqube_image   = "${data.aws_ecr_repository.sonarqube_ecr_repository.repository_url}@${data.external.latest_sonar_image.result.tags}"
    log_stream_prefix = aws_cloudwatch_log_stream.sonar_log_stream.name
    log_group         = aws_cloudwatch_log_group.sonar_log_group.name
    region            = data.aws_region.current.name

    sonardb_url          = "${aws_route53_record.db_entry.fqdn}:${aws_db_instance.sonar_db.port}"
    sonardb_username_arn = aws_ssm_parameter.sonar_db_user.arn
    sonardb_password_arn = aws_ssm_parameter.sonar_db_password.arn
    db_name              = aws_db_instance.sonar_db.name
  }

}

data "external" "latest_sonar_image" {
  program = [
    "aws", "ecr", "describe-images",
    "--repository-name", data.aws_ecr_repository.sonarqube_ecr_repository.name,
    "--query", "{\"tags\": to_string(sort_by(imageDetails,& imagePushedAt)[-1].imageDigest)}",
  ]
}

data "template_file" "allow_ecr_policy" {
  template = file("${path.module}/policies/allow_ecr.json.tpl")

  vars = {
    ecr_repos = jsonencode(
      [
        data.aws_ecr_repository.sonarqube_ecr_repository.arn
      ]
    )
  }
}

data "aws_ecr_repository" "sonarqube_ecr_repository" {
  name = "sonarqube-8-8"
}

data "terraform_remote_state" "account_resources" {
  backend = "s3"
  config = {
    bucket         = "cjse-bichard7-default-sharedaccount-sandbox-bootstrap-tfstate"
    dynamodb_table = "cjse-bichard7-default-sharedaccount-sandbox-bootstrap-tfstate-lock"
    key            = "tfstatefile"
    region         = "eu-west-2"
  }
}
