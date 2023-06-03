# configuring aws as a provider
provider "aws" {
    region = "sa-east-1"
}

variable "istest" {

}

# example using condicionals
resource "aws_instance" "dev" {
  ami = var.ami_id
  instance_type = var.types["sa-east-1"]

  count = var.istest == true ? 1 : 0
}

resource "aws_instance" "prod" {
  ami = var.ami_id
  instance_type = var.types["sa-east-1"]

  count = var.istest == false ? 1 : 0
}


# lauching a ec2
resource "aws_instance" "myec2" {
    ami = var.ami_id
    instance_type = var.types["sa-east-1"]

    # attribute count creates a specified number of the resource
    count = 3
    tags = {
        # you can access the count index to generate unique names
        Name = "${var.ec2_tag_name}-${count.index}"
    }
}

# creating a elastic IP
resource "aws_eip" "lb" {
  vpc      = true
}

# associate elastic IP with a ec2 instance
resource "aws_eip_association" "eip_assoc" {
  instance_id   = aws_instance.myec2[0].id # to access a certain instance by index
  allocation_id = aws_eip.lb.id
}

# creating a security group with inbound rules
resource "aws_security_group" "allow_tls" {
  name        = "kleis-security-group"
  description = "Allow TLS inbound traffic"

  ingress {
    description      = "TLS from VPC"
    from_port        = 443
    to_port          = 443
    protocol         = "tcp"
    cidr_blocks      = ["${aws_eip.lb.public_ip}/32"]
    # cidr_blocks      = [aws_eip.lb.public_ip]
  }
}

# example using variables `vpn_ip` of variables.tf
resource "aws_security_group" "var_demo" {
  name        = "kplabs-variables"

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = [var.vpn_ip]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = [var.vpn_ip]
  }

  ingress {
    from_port   = 53
    to_port     = 53
    protocol    = "tcp"
    cidr_blocks = [var.vpn_ip]
  }
}