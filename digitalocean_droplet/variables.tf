## Droplet
variable "name" {
  description = "Name of the droplet to create"
  type        = string
  nullable    = false
}

variable "image" {
  description = "Image to use for the droplet"
  type        = string
  default     = "ubuntu-22-10-x64"
}

variable "region" {
  description = "Region to use for the droplet"
  type        = string
}

variable "size" {
  description = "Size of the droplet to create"
  type        = string
  default     = "s-1vcpu-1gb"
}

variable "ssh_key" {
  description = "SSH keys to add to the droplet"
  type        = string
}

variable "enable_backups" {
  description = "Enable auto backups"
  type        = bool
  default     = false
}

variable "enable_monitoring" {
  description = "Enable auto backups"
  type        = bool
  default     = true
}

variable "enable_droplet_agent" {
  description = "Enable auto backups"
  type        = bool
  default     = true
}

## Firewall
variable "allowed_ip" {
  type        = list(any)
  default     = []
  description = "Allow list of IPs"
}

variable "allowed_ports" {
  type        = list(any)
  default     = []
  description = "List of allowed ingress ports."
}

variable "protocol" {
  type        = string
  default     = "tcp"
  description = "The protocol of the port being allowed"
}