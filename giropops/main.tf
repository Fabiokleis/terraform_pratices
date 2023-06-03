# Example to retrive information from vault server
provider "aws" {
  profile = "default"
  region  = "sa-east-1"
}

module "vault" {
  source = "./modules/vault"
}

output "psqldb_passwd" {
  value = module.vault.psql_passwd
  sensitive = true
}

output "psqldb_username" {
  value = module.vault.psql_username
  sensitive = true
}