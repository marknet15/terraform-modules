# Homelab Terraform Modules

## Overview

Terraform modules repo for my personal testing and learnings used in my home lab.

## Requirements

Terraform v1.0

## Usage

### proxmox-vm

```terraform
module "marknet_proxmox_vm" {
  source   = "./terraform/proxmox-vm"
  ssh_keys = file("/example/id_rsa.pub")
  gateway  = "192.168.0.1"
  vm_items = [
    {
      name            = "test"
      target_node     = "node"
      source_template = "some-template"
      vcpus           = 1
      memory          = 512
      ip              = "192.168.0.x/24"
    },
    {
      name            = "test1"
      target_node     = "node"
      source_template = "some-template"
      vcpus           = 1
      memory          = 512
      ip              = "192.168.0.x/24"
    }
  ]
}

```

### raspberry-pi

```terraform
module "marknet_raspberry_pi" {
  source          = "./terraform/raspberry-pi"
  username        = "pi"
  password        = "raspberry"
  new_password    = "SomePassword"
  public_key_path = "/example/id_rsa.pub"
  timezone        = "Europe/London"
  gateway         = "192.168.0.1"
  nameserver      = "192.168.0.1"
  domain          = "local"
  subnet_mask     = "/24"

  # Nodes params
  nodes = {
    "node-1" = "192.168.0.5"
  }
}
```
