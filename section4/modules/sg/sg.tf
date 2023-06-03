resource "aws_security_group" "ec2-sg" {
  name = "myec2-sg"

  ingress {
    description = "Allow Inbound from Secret Application"
    from_port   = local.app_port
    to_port     = local.app_port
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}


resource "aws_security_group" "elb-sg" {
  name = "myelb-sg"


  ingress {
    description = "Allow Inbound from Secret Application"
    from_port   = local.app_port
    to_port     = local.app_port
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Example usage of locals
# to prevent user to replace variables
locals {
  app_port = 8433
}

# with returned ids created by sg resources 
# create a output value as a argument to a variable
output "sg_ids" {
  value = [aws_security_group.ec2-sg.id]
}
