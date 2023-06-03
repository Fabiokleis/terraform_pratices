# Example usage of for_each meta argument
provider "aws" {
  region = "sa-east-1"
}

# builtin function toset returns a set datatype from a list
# when toset is used the returned set has the key as the same of value
resource "aws_iam_user" "iam" {
  for_each = toset(["user-01", "user-02", "user-03"])
  name     = each.key
}

resource "aws_instance" "myec2" {
  ami = var.ami_id
  for_each = {
    "key1" = "t2.micro"
    "key2" = "t2.nano"
  }

  instance_type = each.value
  key_name      = each.key

  tags = {
    Name = each.value
  }

}