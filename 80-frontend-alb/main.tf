resource "aws_lb" "ingress_alb" {
  name               = "${local.common_name_suffix}-ingress-alb" # roboshop-dev-backend-alb
  internal           = false
  load_balancer_type = "application"
  security_groups    = [local.ingress_alb_sg_id]
  # it should be private subnet ids
  subnets            = local.public_subnet_ids

  enable_deletion_protection = false # prevents accidental deletion from UI

  tags = merge (
    local.common_tags,
    {
        Name = "${local.common_name_suffix}-ingress-alb"
    }
  )
}
