provider "digitalocean" {
    token = "${var.do_token}"
}


data "digitalocean_ssh_key" "ssh_key" {
  name = "dopensource-training"
}


resource "digitalocean_droplet" "hashicorp" {
        name = "${var.hashicorp-dropletname}${count.index}"
        count = "${var.number_of_environments}"
        region = "nyc1"
        size="1gb"
        image="centos-7-x64"
	      ssh_keys = [ "${data.digitalocean_ssh_key.ssh_key.fingerprint}" ]

}
