resource "aws_route53_record" "mail" {
  name    = "mail.${data.aws_route53_zone.public.name}"
  type    = "CNAME"
  zone_id = data.aws_route53_zone.public.zone_id
  ttl     = 60

  records = [module.postfix_nlb.load_balancer.dns_name]
}
