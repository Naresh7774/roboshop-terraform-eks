resource "aws_ecr_repository" "catalogue" {
  name                 = "${var.project_name}/catalogue"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = false
  }
  force_delete = true
}

resource "aws_ecr_repository" "user" {
  name                 = "${var.project_name}/user"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = false
  }
  force_delete = true
}