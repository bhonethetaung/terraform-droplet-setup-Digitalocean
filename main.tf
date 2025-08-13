terraform {
  required_providers {
    digitalocean = {
      source  = "digitalocean/digitalocean"
      version = "~> 2.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.0"
    }
  }
}

provider "digitalocean" {
  token = var.do_token
}

# Generate random passwords
resource "random_password" "root_pass" {
  count   = var.server_count
  length  = 10
  special = false
}

# Create droplets
resource "digitalocean_droplet" "servers" {
  count  = length(var.server_names)
  name   = var.server_names[count.index]
  region = var.region
  size   = var.size
  image  = var.image
  tags   = var.server_tags

  user_data = templatefile("${path.module}/${var.startupfile}", {
    ROOT_PASSWORD = random_password.root_pass[count.index].result
  })
}

locals {
  server_list = [
    for i in range(length(var.server_names)) : {
      name     = digitalocean_droplet.servers[i].name
      ip       = digitalocean_droplet.servers[i].ipv4_address
      password = random_password.root_pass[i].result
    }
  ]
}

# Write server info to servers.json automatically
resource "local_file" "server_json" {
  filename = "${path.module}/servers.json"
  content  = jsonencode(local.server_list)
}