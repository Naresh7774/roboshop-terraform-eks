resource "aws_security_group_rule" "mongodb_bastion" {
  type              = "ingress"
  security_group_id = local.mongodb_sg_id
  source_security_group_id = local.bastion_sg_id
  from_port         = 22
  protocol          = "tcp"
  to_port           = 22
}
# resource "aws_security_group_rule" "mongodb_catalogue" {
#   type              = "ingress"
#   security_group_id = local.mongodb_sg_id
#   source_security_group_id = local.catalogue_sg_id
#   from_port         = 27017
#   protocol          = "tcp"
#   to_port           = 27017
# }



# resource "aws_security_group_rule" "mongodb_user" {
#   type              = "ingress"
#   security_group_id = local.mongodb_sg_id
#   source_security_group_id = local.user_sg_id
#   from_port         = 27017
#   protocol          = "tcp"
#   to_port           = 27017
# }



# Refis accepting connections from bastion on port 22
resource "aws_security_group_rule" "redis_bastion" {
  type              = "ingress"
  security_group_id = local.redis_sg_id
  source_security_group_id = local.bastion_sg_id
  from_port         = 22
  protocol          = "tcp"
  to_port           = 22
}



# resource "aws_security_group_rule" "redis_user" {
#   type              = "ingress"
#   security_group_id = local.redis_sg_id
#   source_security_group_id = local.user_sg_id
#   from_port         = 6379
#   protocol          = "tcp"
#   to_port           = 6379
# }



# resource "aws_security_group_rule" "redis_cart" {
#   type              = "ingress"
#   security_group_id = local.redis_sg_id
#   source_security_group_id = local.cart_sg_id
#   from_port         = 6379
#   protocol          = "tcp"
#   to_port           = 6379
# }



# Created as part of ticket 1234GDF
resource "aws_security_group_rule" "mysql_bastion" {
  type              = "ingress"
  security_group_id = local.mysql_sg_id
  source_security_group_id = local.bastion_sg_id
  from_port         = 22
  protocol          = "tcp"
  to_port           = 22
}
