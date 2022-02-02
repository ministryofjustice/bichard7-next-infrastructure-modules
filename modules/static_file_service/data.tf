data "template_file" "static_file_bucket" {
  template = file("${path.module}/policies/static_file_bucket.json.tpl")

  vars = {
    static_file_bucket_arn = aws_s3_bucket.static_file_bucket.arn
  }
}
