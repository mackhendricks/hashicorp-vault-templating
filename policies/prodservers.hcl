# Manage the SSH backend
path "ssh/creds/prodadmin/*" {
  capabilities = [ "create", "read", "update", "delete", "list" ]
}

path "ssh/sign/prodadmin/*" {
  capabilities = [ "create", "read", "update", "delete", "list" ]
}

path "ssh/sign/prodadmin" {
  capabilities = [ "create", "read", "update", "delete", "list" ]
}

path "sys/mounts" {
   capabilities = ["read"]
}
