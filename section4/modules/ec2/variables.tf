variable "instance_type" {
  description = "type of ec2, default free tier"
  type        = map(any)
  default = {
    default = "t2.micro"
    dev     = "t2.nano"
    prod    = "t2.medium"
  }
}

variable "instance_sg_ids" {
  type        = list(string)
  description = "list of identifier of security group id"
  default     = ["default"]
}