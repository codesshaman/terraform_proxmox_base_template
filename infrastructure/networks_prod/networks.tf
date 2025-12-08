# networks.tf

module "proxmox_network_vlan" {
  source = "../../modules/proxmox_network_vlan"

  providers = {
    proxmox = proxmox.second
  }

  base_bridge     = "vmbr10101"
  vlan_name       = "vlan180"
  node_name       = var.pm_node_name
  vlan_id         = 180
  comment         = "VLAN network created by Terraform"
}


module "proxmox_network_bridge" {
  source = "../../modules/proxmox_network_bridge"

  providers = {
    proxmox = proxmox.second
  }

  node_name       = var.pm_node_name
  vlan_id         = 1010
  interface       = "vmbr0"
  bridge_name     = "vmbr10101"
  bridge_address  = "10.10.1.0/24"
  comment         = "Bridge network created by Terraform"
}
