# Digital Ocean Token 
variable "do_token" {
}

# Optional Prepfix for the workshop
variable "prefix" {
	default =""
}

# The private key being used to connect to the VM to provision them
variable "pvt_key" {
  default = "~/.ssh/dopensource-training"
}


# The name ofthe FusionPBX Instances
variable "hashicorp-dropletname" {
  default = "hashicorp"
}

# The Number of Environments to Deploy
variable "number_of_environments" {
  default = "1"
}

