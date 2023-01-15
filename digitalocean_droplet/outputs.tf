output "ip" {
  value = digitalocean_droplet.droplet.ipv4_address
}

output "id" {
  value = digitalocean_droplet.droplet.id
}
