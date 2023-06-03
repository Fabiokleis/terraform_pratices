# Example using provisioner block
resource "aws_instance" "myec2" {
  ami           = "ami-0da62eb5869c785b9"
  instance_type = "t2.micro"
  key_name      = "terraform_kp"

  vpc_security_group_ids = [aws_security_group.allow_ssh.id]
  provisioner "remote-exec" {
    on_failure = fail # if fails also fail the apply command
    inline = [
      "sudo dnf install -y nginx",
      "sudo systemctl start nginx"
    ]

    connection {
      type        = "ssh"
      host        = self.public_ip
      user        = "ec2-user"
      private_key = file("./terraform_kp.pem")
    }
  }

  # after installation of nginx do a curl in instance
  provisioner "local-exec" {
    command    = "curl ${aws_instance.myec2.public_ip}"
    on_failure = continue # if fails dont fail the apply command
  }
}

# Create a sg to allow ssh and tcp connection to nginx server
resource "aws_security_group" "allow_ssh" {
  name        = "allow_ssh"
  description = "allow ssh using terraform_kp.pem"

  ingress {
    from_port   = "80"
    to_port     = "80"
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = "22"
    to_port     = "22"
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
}

# elastic ip
resource "aws_eip" "lb" {
  vpc   = true
  count = 1
}

# # null_resource is used to run something after a resource action
# resource "null_resource" "ip_check" {

#     # allow to run this null_resource when this 'triggers' change
#     triggers = {
#         latest_ips = join(",", aws_eip.lb[*].public_ip)
#     }

#     # in this case are running a local provisioner
#     provisioner "local-exec" {
#       command = "echo Latest IPs created are ${null_resource.ip_check.triggers.latest_ips} > sample.txt"
#     }
# }
# the samething but using the latest and correctly way
resource "terraform_data" "ip_check2" {

  triggers_replace = {
    latest_ips = join(",", aws_eip.lb[*].public_ip)
  }
  provisioner "local-exec" {
    command = "echo Latest IPs created are ${terraform_data.ip_check2.triggers_replace.latest_ips} > sample.txt"
  }
}