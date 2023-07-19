data "aws_route53_zone" "route53_zone" {
  name         = var.hosted_zone_name
  private_zone = false
}

resource "aws_route53_record" "cloud_web_cname_record" {
  zone_id = data.aws_route53_zone.route53_zone.id
  name    = "${var.cloud_web_subdomain_name}.${var.hosted_zone_name}"
  type    = "CNAME"
  ttl     = "60"
  records = [module.demo_web.alb_dns]
}

resource "aws_acm_certificate" "cloud_web_acm_certificate" {
  domain_name       = "${var.cloud_web_subdomain_name}.${var.hosted_zone_name}"
  validation_method = "DNS"
}

resource "aws_route53_record" "cloud_web_cert_validation_record" {
  for_each = {
    for dvo in aws_acm_certificate.cloud_web_acm_certificate.domain_validation_options : dvo.domain_name => {
      name   = dvo.resource_record_name
      record = dvo.resource_record_value
      type   = dvo.resource_record_type
    }
  }
  allow_overwrite = true
  name            = each.value.name
  records         = [each.value.record]
  ttl             = 60
  type            = each.value.type
  zone_id         = data.aws_route53_zone.route53_zone.zone_id
}

resource "aws_acm_certificate_validation" "cloud_web_acm_cert_validation" {
  certificate_arn         = aws_acm_certificate.cloud_web_acm_certificate.arn
  validation_record_fqdns = [for record in aws_route53_record.cloud_web_cert_validation_record : record.fqdn]
}

