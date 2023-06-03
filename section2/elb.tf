# configuring aws as a provider
provider "aws" {
    region = "sa-east-1"
}

# Create a new load balancer
resource "aws_elb" "bar" {
  name               = var.elb_name
  availability_zones = var.az

  listener {
    instance_port     = 8000
    instance_protocol = "http"
    lb_port           = 80
    lb_protocol       = "http"
  }

  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 3
    target              = "HTTP:8000/"
    interval            = 30
  }
  
  cross_zone_load_balancing   = true
  idle_timeout                = var.tm
  connection_draining         = true
  connection_draining_timeout = var.tm

  tags = {
    Name = "foobar-terraform-elb"
  }
}

# example using a list variable to generate a custom name
# based on count attribute and his index
resource "aws_iam_user" "lb" {
    count = 3
    name = var.elb_names[count.index]
    path = "/system/"
}