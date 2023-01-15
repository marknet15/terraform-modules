terraform {
  required_providers {
    digitalocean = {
      source  = "digitalocean/digitalocean"
      version = "~> 2.0"
    }
  }
}

data "digitalocean_ssh_key" "key" {
  name = var.ssh_key
}

resource "digitalocean_droplet" "droplet" {
  name          = var.name
  image         = var.image
  region        = var.region
  size          = var.size
  backups       = var.enable_backups
  monitoring    = var.enable_monitoring
  droplet_agent = var.enable_droplet_agent
  ssh_keys      = [data.digitalocean_ssh_key.key.id]

  lifecycle {
    create_before_destroy = true
  }
}


resource "digitalocean_firewall" "droplet_firewall" {
  name = var.name

  droplet_ids = [digitalocean_droplet.droplet.id]

  dynamic "inbound_rule" {
    iterator = port
    for_each = var.allowed_ports
    content {
      port_range       = port.value
      protocol         = var.protocol
      source_addresses = var.allowed_ip
    }
  }

  inbound_rule {
    protocol         = "icmp"
    source_addresses = ["0.0.0.0/0", "::/0"]
  }

  outbound_rule {
    protocol              = "tcp"
    port_range            = "1-65535"
    destination_addresses = ["0.0.0.0/0", "::/0"]
  }

  outbound_rule {
    protocol              = "udp"
    port_range            = "1-65535"
    destination_addresses = ["0.0.0.0/0", "::/0"]
  }
}
