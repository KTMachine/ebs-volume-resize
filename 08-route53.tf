# Get Route53 hosted zone data if DNS is enabled
data "aws_route53_zone" "selected" {
  count = var.create_public_dns && var.dns_zone_name != "" ? 1 : 0
  name         = var.dns_zone_name
  private_zone = false
}

# Create Route53 DNS record if enabled
resource "aws_route53_record" "instance" {
  count = var.create_public_dns && var.dns_zone_name != "" ? 1 : 0

  zone_id = data.aws_route53_zone.selected[0].zone_id
  name    = "${var.dns_record_name}.${var.dns_zone_name}"
  type    = "A"
  ttl     = "300"
  records = [aws_instance.winter_is_coming.public_ip]
}