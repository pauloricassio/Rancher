terraform {
  required_providers {
    digitalocean = {
      source = "digitalocean/digitalocean"
      version = "~> 2.0"
    }
  }
}

provider "digitalocean" {
  token = var.do_token
}

resource "digitalocean_droplet" "rancher-server" {
  image  = "ubuntu-22-10-x64"
  name   = "rancher-server"
  region = var.region
  size   = "s-2vcpu-4gb"
  ssh_keys = [digitalocean_ssh_key.access_docean.fingerprint]
}

resource "digitalocean_ssh_key" "access_docean" {
  name = "access_docean"
  public_key = file("/home/paulo/access_docean.pub") 
}

output "IPrancher-server" {
  value = digitalocean_droplet.rancher-server.ipv4_address
}