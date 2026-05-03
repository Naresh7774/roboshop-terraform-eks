resource "aws_acm_certificate" "roboshop" {
  domain_name       = "*.${var.domain_name}"
  validation_method = "DNS"

  tags = merge(
    local.common_tags,
    {
        Name = local.common_name_suffix
    }
  )

  lifecycle {
    create_before_destroy = true
  }
}

