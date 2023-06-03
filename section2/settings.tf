# Example of terraform block
terraform {
  required_version = "> 1.3" # specify a version of terraform bin
  required_providers {
    aws = "~> 4.0" # specify the provider version
  }
}

provider "aws" {
  region     = "sa-east-1"
}

resource "aws_instance" "myec2" {
   ami = "ami-0b1e534a4ff9019e0"
   instance_type = "t2.micro"
}