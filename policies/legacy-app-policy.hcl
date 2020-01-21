# Define Access to Legacy-App Secrets

path "secret/data/*" {
  capabilities = ["read"]
}

path "secret/data/legacy-app/*" {
  capabilities = [ "read", "list" ]
}

path "auth/token/*" {
  capabilities = ["create", "update"]
}
