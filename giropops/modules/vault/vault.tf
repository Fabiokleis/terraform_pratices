provider "vault" {
  # It is strongly recommended to configure this provider through the
  # environment variables described above, so that each user can have
  # separate credentials set in the environment.
  #
  # This will default to using $VAULT_ADDR
  # But can be set explicitly
  address = "http://192.168.0.199:8200"
  token = "token"
}

data "vault_generic_secret" "psqldb" {
  path = "kv/postgresql"
}

output "psql_passwd" {
  value = data.vault_generic_secret.psqldb.data["postgresql_db_passwd"]
}
output "psql_username" {
  value = data.vault_generic_secret.psqldb.data["postgresql_db_user"]
}