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