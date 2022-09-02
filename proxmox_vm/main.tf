terraform {
  experiments = [module_variable_optional_attrs]
  required_providers {
    proxmox = {
      source = "Telmate/proxmox"
    }
    pihole = {
      source = "ryanwholey/pihole"
    }
  }
}

resource "pihole_dns_record" "record" {
  for_each = { for vm in var.vm_items : vm.name => vm }
  domain   = "${each.value.name}.${var.domain}"
  ip       = element(split("/", each.value.ip), 0)
}

resource "proxmox_vm_qemu" "vm" {
  for_each    = { for vm in var.vm_items : vm.name => vm }
  name        = each.value.name
  clone       = each.value.source_template
  target_node = each.value.target_node
  cores       = each.value.cores
  memory      = each.value.memory
  ipconfig0   = "ip=${each.value.ip},gw=${var.gateway}"
  sshkeys     = var.ssh_keys

  disk {
    slot     = 0
    size     = each.value.storage_size
    type     = "scsi"
    storage  = var.storage
    iothread = 1
  }
}
