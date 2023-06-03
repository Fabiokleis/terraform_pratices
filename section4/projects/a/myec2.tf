# references ec2.tf module
module "ec2module" {
  source = "../../modules/ec2"

  # overwrite value of instance_type variable
  # instance_type = "t2.large"


  # overwrite value of sg ids with a output of sg module
  instance_sg_ids = module.mysg.sg_ids
}

# to show information of output of module
output "sg_id" {
  value = module.mysg.sg_ids
}

# shows the current workspace
output "workspace" {
  value = terraform.workspace
}