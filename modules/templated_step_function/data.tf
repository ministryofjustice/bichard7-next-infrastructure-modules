data "aws_s3_bucket_object" "state_machine_definition_template" {
  bucket = var.template_file_bucket
  key    = var.template_file_key

  provider = aws.parent
}

data "template_file" "state_machine_definition" {
  template = data.aws_s3_bucket_object.state_machine_definition_template.body

  vars = var.template_variables
}
