pid_file = "./pidfile"

auto_auth {
  method "approle" {
    mount_path = "auth/approle"
    config = {
      type = "approle"
      role = "legacy-app"
      role_id_file_path = "/Users/mack/vault-role_id"
    }
  }

  sink "file" {
    config = {
      path = "/Users/mack/vault-token-via-agent"
    }
  }
}

vault {
  address = "http://127.0.0.1:8200"
}

template {
  source      = "/Users/mack/Documents/hashicorp-vault-templating/app/settings.tmpl"
  destination = "/Users/mack/Documents/hashicorp-vault-templating/app/settings.py"
  command = "pkill -f 'Python app.py';cd app;python3.7 app.py"
}
