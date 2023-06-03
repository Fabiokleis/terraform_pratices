provider "aws" {
  region     = "sa-east-1"
  profile = "default"
}

resource "aws_instance" "myec2" {
  ami           = "ami-0da62eb5869c785b9"
  instance_type = "t2.micro"

  tags = {
    Name = "myfirstec2"
  }
}