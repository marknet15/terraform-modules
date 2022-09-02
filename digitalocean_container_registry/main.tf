terraform {
  required_providers {
    digitalocean = {
      source  = "digitalocean/digitalocean"
      version = "~> 2.0"
    }
  }
}

resource "digitalocean_container_registry" "registry" {
  name                   = var.name
  subscription_tier_slug = var.subscription_tier
}