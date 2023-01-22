output "id" {
  description = "The DNS zone ID"
  value       = lookup(data.cloudflare_zones.lookup.zones[0], "id")
}
