# Source template takes the name of the template as found in Proxmox
variable "vm_items" {
  description = "Dictionary of the Proxmox VMs to create"
  type = list(object({
    name            = string
    target_node     = string
    source_template = string
    cores           = optional(number)
    memory          = optional(number)
    storage_size    = string
    ip              = string
  }))
}

variable "gateway" {
  description = "Network gateway router to use."
  type        = string
}

variable "domain" {
  description = "DNS zone"
  type        = string
}

variable "storage" {
  description = "Proxmox storage to utilise"
  type        = string
}

variable "ssh_keys" {
  description = "SSH keys to configure on the VM"
  type        = string
}
