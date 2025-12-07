# resources.tf

terraform {
  required_providers {
    proxmox = {
      source = "bpg/proxmox"
    }
  }
}

locals {
  vlan_interface = "${var.interface}.${var.vlan_id}"
  comment = var.comment != "" ? var.comment : "VLAN ${var.vlan_id}"
}

resource "proxmox_virtual_environment_network_linux_vlan" "vlan" {
  depends_on = [
    var.base_bridge
  ]

  node_name = var.node_name
  name      = "${var.base_bridge}.${var.vlan_id}"
  comment   = var.comment
}

