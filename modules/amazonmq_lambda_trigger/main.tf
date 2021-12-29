# We cannot use AmazonMQ as a trigger for the Lambda as the Terraform module
# has not yet been updated to support the changes to the AWS API for AmazonMQ
# See: https://github.com/hashicorp/terraform-provider-aws/issues/16074
resource "null_resource" "setup_event_listener" {
  provisioner "local-exec" {
    interpreter = ["/bin/bash", "-c"]
    command     = <<-EOF
      ${path.module}/scripts/create_update_or_delete_mq_lambda_event_source.sh \
        ${self.triggers.current_region_id} \
        ${self.triggers.assume_role_arn} \
        ${self.triggers.mq_arn} \
        ${self.triggers.lambda_arn} \
        ${self.triggers.secret_arn} \
        ${self.triggers.queue_name}
    EOF
  }

  provisioner "local-exec" {
    when        = destroy
    interpreter = ["/bin/bash", "-c"]
    command     = <<-EOF
      ${path.module}/scripts/create_update_or_delete_mq_lambda_event_source.sh \
        ${self.triggers.current_region_id} \
        ${self.triggers.assume_role_arn} \
        ${self.triggers.mq_arn} \
        ${self.triggers.lambda_arn} \
        ${self.triggers.secret_arn} \
        ${self.triggers.queue_name} \
        delete
    EOF
  }

  depends_on = [
    var.region_id,
    var.assume_role_arn,
    var.queue_arn,
    var.lambda_arn,
    var.queue_secret_arn,
    var.queue_name
  ]

  triggers = {
    always_run        = timestamp()
    current_region_id = var.region_id
    assume_role_arn   = var.assume_role_arn
    mq_arn            = var.queue_arn
    lambda_arn        = var.lambda_arn
    secret_arn        = var.queue_secret_arn
    queue_name        = var.queue_name
  }
}
