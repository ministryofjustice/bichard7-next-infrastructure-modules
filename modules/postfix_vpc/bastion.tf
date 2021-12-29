resource "aws_launch_template" "bastion" {
  name_prefix   = local.env
  image_id      = data.aws_ami.amazon_linux_2.id
  instance_type = "t2.micro"
  key_name      = aws_key_pair.aws_keypair.key_name

  user_data = base64encode(data.template_file.bastion_instance_userdata.rendered)

  network_interfaces {
    associate_public_ip_address = true
    delete_on_termination       = true
    security_groups = [
      aws_security_group.bastion.id
    ]
  }

  iam_instance_profile {
    arn = aws_iam_instance_profile.bastion_instance_profile.arn
  }

  metadata_options {
    http_endpoint = "enabled"
    http_tokens   = "required"
  }

  tags = var.tags
}

resource "aws_autoscaling_group" "bastion" {
  name             = "${local.env}-bastion-asg"
  desired_capacity = var.bastion_count
  max_size         = var.bastion_count
  min_size         = var.bastion_count


  launch_template {
    id      = aws_launch_template.bastion.id
    version = aws_launch_template.bastion.latest_version
  }

  vpc_zone_identifier = module.postfix_vpc.public_subnets

  dynamic "tag" {
    for_each = merge(var.tags, { Name = "${var.name}-bastion" })
    content {
      key                 = tag.key
      propagate_at_launch = true
      value               = tag.value
    }
  }

  depends_on = [aws_launch_template.bastion]

  lifecycle {
    ignore_changes = [
      tags
    ]
  }
}
