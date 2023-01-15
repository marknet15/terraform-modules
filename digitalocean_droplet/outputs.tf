output "ip" {
  value = digitalocean_droplet.droplet.ipv4_address
}

output "id" {
  value = digitalocean_droplet.droplet.id
}

output "name" {
  value = digitalocean_droplet.droplet.name
}