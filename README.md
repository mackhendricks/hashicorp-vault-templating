# HashiCorp Detroit User Group Nov 2019

## Topic: SSH Secrets Management with Vault

We will walk thru the steps to configure HashiCorp Vault as the mechanism to grant users with audited access to Linux systems via SSH.  This will prevent the insecure SSH key sprawl that many organizations deal with.

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
```

# Enable the SSH Secret Engine and setup Policies

```
vault secrets enable ssh
vault policy write prodservers ./policies/prodservers.hcl
```

# Create a User

```
vault auth enable userpass
vault write auth/userpass/users/mack password="password" policies=prodservers
```


# Generate a Key Pair for Target SSH Servers

```
vault write ssh/config/ca generate_signing_key=true
vault write ssh/roles/prodadmin @./roles/prodadmin.json
```


# Enable Auditing

Enable auditing to help you troubleshoot any issues.  Note, the audit file will be created for you

```
vault audit enable file file_path=/tmp/vault_audit.log
```

# Configure the Target Host SSH Server

```
scp <-i [ssh key]> prodservers.pem root@target_host:/etc/ssh/prodservers.pem
vi /etc/ssh/sshd_config
#add this to the end of the file
TrustedUserCAKeys /etc/ssh/prodservers.pem
systemctl restart sshd
```

# Let's Login Vault as mack
```
 vault login -method userpass username=mack
```

# Vault will sign my public key

```
vault write -field=signed_key ssh/sign/prodadmin \
    public_key=@$HOME/.ssh/id_rsa.pub > ~/.ssh/signed-cert.pub
```

# SSH into the Target Host

My target system is centos so the username is "centos"

```
#Check out the signed key
ssh-keygen -Lf ~/.ssh/signed-cert.pub
#SSH into the target system
ssh -i signed-cert.pub -i ~/.ssh/id_rsa centos@target_host
```

# Optional (Provision a SSH Target Host)

Provision a SSH Target Host using Terraform.  I use Digital Ocean for my test environments.  So, these Terraform scripts are configured for them.

## Provision Server

```
terraform init terraform/
terraform apply -var do_token=$DIGITALOCEAN_TOKEN terraform/
```

## Destroy Server
```
terraform destroy
```
