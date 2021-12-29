resource "aws_route53_record" "mail" {
  name    = "mail.${data.aws_route53_zone.public.name}"
  type    = "A"
  zone_id = data.aws_route53_zone.public.zone_id
  ttl     = 60

  records = concat(
    aws_network_interface.static_ip.*.private_ip,
    aws_eip.postfix_static_ip.*.public_ip
  )
}
