# Using Open source module
  module "catalogue" {
  source = "terraform-aws-modules/security-group/aws"

  name        = "${local.common_name_suffix}-catalogue"
  use_name_prefix = false
  description = "Security group for catalogue with custom ports open within VPC, egress all traffic"
  vpc_id      = data.aws_ssm_parameter.vpc_id.value

}




# Frontend accepting traffic from frontend ALB
resource "aws_security_group_rule" "frontend_frontend_alb" {
  type              = "ingress"
  security_group_id = module.sg[9].sg_id # frontend SG ID
  source_security_group_id = module.sg[11].sg_id # frontend ALB SG ID
  from_port         = 80
  protocol          = "tcp"
  to_port           = 80
}