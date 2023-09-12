terraform {
  required_providers {
    vault = {
      source  = "hashicorp/vault"
      version = "3.20.0"
    }
  }
  required_version = ">= 1.2.0"
}

provider "vault" {
  skip_child_token = true
  address          = "http://localhost:8200"
  auth_login_token_file {
    filename = "/tmp/file-foo" # path do token gerado via vault agent
  }
}

data "vault_generic_secret" "ansible_moodle" {
  path = "secret/ansible/moodle"
}

output "ansible_moodle_vars" {
  sensitive = true
  value     = data.vault_generic_secret.ansible_moodle.data
}