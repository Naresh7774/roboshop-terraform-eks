variable "vpc_cidr" {
    default = "10.0.0.0/16"
}

variable "project_name" {
    default = "roboshop"
}

variable "environment"{
    default = "dev"
}

variable "vpc_tags" {
    default = {
        Purpose = "Roboshop VPC"
        DontDelete = "true"
    }
}
