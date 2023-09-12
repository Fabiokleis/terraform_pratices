vault {
  address = "http://192.168.0.16:8200"
  retry {
    num_retries = 5
  }
}

auto_auth {
  method {
    type = "approle"

    config = {
      role_id_file_path = "./roleid"
      secret_id_file_path = "./secretid"
    }
  }
  sink {
    type = "file"

    config = {
      path = "/tmp/file-foo"
    }
  }
}

api_proxy {
  use_auto_auth_token = true
}

listener "tcp" {
  address = "127.0.0.1:8200"
  tls_disable = true
}