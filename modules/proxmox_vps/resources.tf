# modules/proxmox_network_vlan/main.tf

terraform {
  required_providers {
    proxmox = {
      source  = "bpg/proxmox"
      version = "0.89.0"
    }
  }
}

resource "proxmox_virtual_environment_vm" "debian_vm" {
  name      = "test-debian"
  node_name = "pve"

  # should be true if qemu agent is not installed / enabled on the VM
  stop_on_destroy = true

  initialization {
    user_account {
      username = "user"
      password = "password"
    }
  }

  disk {
    datastore_id = "local-lvm"
    # qcow2 image downloaded from https://cloud.debian.org/images/cloud/bookworm/latest/ and renamed to *.img
    # the image is not of import type, so provider will use SSH client to import it
    file_id   = "local:iso/debian-12-genericcloud-amd64.img"
    interface = "virtio0"
    iothread  = true
    discard   = "on"
    size      = 20
  }
}