# declaring variables
variable "vpn_ip" {
  default = "116.50.30.20/32"
}

# variable that doesn't initialize default value
variable "ec2_tag_name" {}

# variable with declared type and default value
variable "ami_id" {
  type    = string
  default = "ami-0da62eb5869c785b9"
}

# list, string and number types
variable "elb_name" {
  type = string
}

variable "az" {
  type = list(any)
}

variable "tm" {
  type = number
}

# list and map types
# to get values from list use list[index] exp: list[1]
variable "list" {
  type    = list(any)
  default = ["m5.large", "m5.xlarge", "t2.medium"]
}

# to get values from maps, use types["key"] exp: types["sa-east-1"]
variable "types" {
  type = map(any)
  default = {
    sa-east-1  = "t2.micro"
    us-west-2  = "t2.nano"
    ap-south-1 = "t2.small"
  }
}

variable "elb_names" {
  type    = list(any)
  default = ["dev-lb", "stage-lb", "prod-lb"]
}

# to declare a set we declare like list
variable "users" {
  type    = set(string)
  default = ["user-01", "user-02", "user-03"]
}