# Exemple usage of Data Source
provider "aws" {
  region     = "sa-east-1"
}

# section data fetchs information from configured provider
data "aws_ami" "app_ami" {
  most_recent = true       # flag to grab only the most recent returned ami
  owners      = ["amazon"] # configuring the owner of the image, we can have multiple owners


  # we can apply filters in each column of the data
  # also can apply a expand expression like `*` in values
  filter {
    name   = "name"
    values = ["amzn2-ami-hvm*"]
  }
}

# simply creates a new instance based on returned information of data section
resource "aws_instance" "instance-1" {
  ami           = data.aws_ami.app_ami.id
  instance_type = "t2.micro"
}