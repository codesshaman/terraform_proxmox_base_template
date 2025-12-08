# modules/proxmox_vps/resources.tf

terraform {
  required_providers {
    proxmox = {
      source  = "bpg/proxmox"
    }
  }
}

resource "proxmox_virtual_environment_vm" "vps_vm" {
  name        = var.vm_name
  node_name   = var.node_name
  description = var.description

  # should be true if qemu agent is not installed / enabled on the VM
  stop_on_destroy = true

  initialization {
    user_account {
      username = var.username
      password = var.password
    }
  }

  disk {
    datastore_id = var.datastore
    # qcow2 image downloaded from https://cloud.debian.org/images/cloud/bookworm/latest/ and renamed to *.img
    # the image is not of import type, so provider will use SSH client to import it
    file_id   = var.image_path
    interface = var.interface
    iothread  = true
    ssd        = true
    discard   = "on"
    size      = var.disk_size
  }
}