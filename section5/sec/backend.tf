terraform {
  backend "s3" {
    bucket = "kleis-terraform"
    key    = "security/terraform.tfstate"
    region = "sa-east-1"
    dynamodb_table = "terraform-state-locker"
  }

  required_providers {
    aws = {
        source = "hashicorp/aws"
    }
  }
}
