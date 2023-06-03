# Example using locals

provider "aws" {
    region = "sa-east-1"
}

locals {
    common_tags = {
        Owner = "DevOps Team"
        service = "backend"
    }
}

resource "aws_instance" "app-dev" {
    ami = var.ami_id
    instance_type = var.types["sa-east-1"]
    tags = local.common_tags
}

resource "aws_instance" "db-dev" {
    ami = var.ami_id
    instance_type = var.types["sa-east-1"]
    tags = local.common_tags
}

resource "aws_ebs_volume" "db_ebs" {
    availability_zone = var.az[0]
    size = 8
    tags = local.common_tags
}