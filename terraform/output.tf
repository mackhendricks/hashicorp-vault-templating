output "instance_ip_addr" {
	value = "${digitalocean_droplet.hashicorp.hashicorp0.ipv4_address}"
}
