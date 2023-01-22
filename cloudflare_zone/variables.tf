variable "zone" {
  description = "Name of DNS zone to manage records in"
  type        = string
  nullable    = false
}

variable "records" {
  type        = list(any)
  default     = []
  description = <<-DOC
    name:
      The name of the record to create.
    type:
      What type the record is, I.E CNAME
    value:
      The value of the record.
    ttl:
      The TTL of the record.
      Default value: 1 to match with general Cloudflare needs.
    priority:
      The priority of the record.
    proxied:
      Whether the record gets Cloudflare's origin protection enabled.
      Default value: false.
  DOC
}
