# Vault Templating Example

The purpose of this example is to demonstrate how a legacy or COT's application would leverage Vault without being Vault aware

## Download and Install HashiCorp Vault

1. Vault 1.3.0 OSS (Open Source Version) can be downloaded from [here](https://releases.hashicorp.com/vault/1.3.0/)

2. Unzip Vault

3. Place the Vault binary in your path

Alternatively, on a Mac, you can use brew to install Vault


# Start Vault in Developer mode

Open up a terminal window and execute the following command.

```
vault server -dev -dev-root-token-id=root
```

The above command will start a vault server in developer mode.  The value of the root token in this case is "root".  Never do this in production.

# Setup You Vault Environment

Execute the following command if on Linux or Mac OS

```
. ./scripts/vault_env.sh

# Test You Can Access vault
vault status
```

# Add Secrets to Vault

```
vault kv put secret/legacy-app username=mack password=Has4KidsandBroke force_restart=no
```

# Create Policy

```
vault policy write legacy-app-policy ./policies/legacy-app-policy.hcl
```

# Enable AppRole Auth Method and Create Approle
```
vault auth enable approle
vault write auth/approle/role/legacy-app @roles/legacy-app.json
```

# Get the Role ID from Newly Created Role
```
vault read auth/approle/role/legacy-app/role-id
```

# Test the AppRole

Test the AppRole before starting the Vault Agent.  You just want to make sure it works.  

```
# Login
vault write auth/approle/login role_id=<role id from above>
# You will be provided a token.  Use that token to get Secrets
export VAULT_TOKEN=
# Get the secrets
vault kv get secret/legacy-app
```

# Validate the Vault Agent is Working

1.  Put the role id into this file: /tmp/vault-role_id
2.  Change the path of the source and destination paths to reflect your path

```
# Start the Vault Agent
vault agent -config=agent/config.hcl
# Validate the Destination File was Created
# Change the values of the secrets and see the Destination File be updated
```
