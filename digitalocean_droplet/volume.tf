resource "digitalocean_volume" "volume" {
  for_each                = { for volume in var.volumes : volume.name => volume }
  region                  = each.value.region
  name                    = each.value.name
  size                    = each.value.size
  initial_filesystem_type = "ext4"
  description             = each.value.description
}

resource "digitalocean_volume_attachment" "volume_attach" {
  for_each   = digitalocean_volume.volume
  droplet_id = digitalocean_droplet.droplet.id
  volume_id  = each.value.id
}
