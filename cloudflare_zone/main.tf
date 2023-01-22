terraform {
  required_version = ">= 1.0.0"
  required_providers {
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "~> 3.0"
    }
  }
}

data "cloudflare_zones" "lookup" {
  filter {
    name = var.zone
  }
}

resource "cloudflare_record" "record" {
  for_each = { for record in var.records : record.name => record }

  zone_id  = lookup(data.cloudflare_zones.lookup.zones[0], "id")
  name     = each.value.name
  value    = each.value.value
  type     = each.value.type
  priority = lookup(each.value, "priority", null)
  proxied  = lookup(each.value, "proxied", false)
  ttl      = lookup(each.value, "ttl", 1)
}
