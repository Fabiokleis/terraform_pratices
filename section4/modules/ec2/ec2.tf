resource "aws_instance" "myec2" {
  ami = "ami-0da62eb5869c785b9"
  # based on terraform workspace change the instance type
  instance_type          = lookup(var.instance_type, terraform.workspace)
  vpc_security_group_ids = var.instance_sg_ids
}
