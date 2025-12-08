# modules/proxmox_network_bridge/resources.tf

terraform {
  required_providers {
    proxmox = {
      source = "bpg/proxmox"
    }
  }
}

locals {
  vlan_interface = "${var.interface}.${var.vlan_id}"
}

resource "proxmox_virtual_environment_network_linux_bridge" "bridge" {

  node_name = var.node_name
  name      = var.bridge_name

  address = var.bridge_address
  comment = var.comment

  ports = [
    local.vlan_interface
  ]
}
