# Example usage of dynamic block
# this example shows how to avoid writting a lot of code to create resources like before.tf
variable "sg_ports" {
  type        = list(number)
  description = "list of ingress ports"
  default     = [8200, 8201, 8300, 9200, 9500]
}

# Security Group Resource.
resource "aws_security_group" "dynamicsg" {
  name        = "dynamic-sg"
  description = "Ingress for Vault"

  # creating the ingress rules dynamically
  # by iterating over variable sg_ports
  # and configuring the ports
  dynamic "ingress" {
    for_each = var.sg_ports # set the iterable variable
    iterator = port         # set the name of iterator
    content {
      from_port   = port.value
      to_port     = port.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }

  dynamic "egress" {
    for_each = var.sg_ports
    content {
      from_port   = egress.value # accessing directly without iterator
      to_port     = egress.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }
}
