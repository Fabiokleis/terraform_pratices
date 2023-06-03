data "terraform_remote_state" "eip" {
  backend = "s3"

  config = {
    bucket = "kleis-terraform"
    key = "network/terraform.tfstate"
    region = "sa-east-1"
  }
}