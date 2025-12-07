# main.tf

# Proxmox povider configuration
terraform {
  required_providers {
    proxmox = {
      source  = "bpg/proxmox"
      version = "~> 0.87.0"
    }
  }

  required_version = ">= 1.6"
}

# First Proxmox node settings
provider "proxmox" {
  alias     = "first"
  endpoint  = var.pm_first_node_api_url
  api_token = "${var.pm_first_node_api_token_id}=${var.pm_first_node_api_token_secret}"
  insecure  = var.proxmox_tls_insecure
}

# Second Proxmox node settings
provider "proxmox" {
  alias     = "second"
  endpoint  = var.pm_second_node_api_url
  api_token = "${var.pm_second_node_api_token_id}=${var.pm_second_node_api_token_secret}"
  insecure  = var.proxmox_tls_insecure
}

module "proxmox_network_bridge" {
  source = "../modules/proxmox_network_bridge"

  providers = {
    proxmox = proxmox.second
  }

  node_name       = var.pm_second_node_name
  vlan_id         = 1010
  interface       = "vmbr0"
  bridge_name     = "vmbr10101"
  bridge_address  = "10.10.1.0/24"
  comment         = "Bridge network created by Terraform"
}

module "proxmox_network_vlan" {
  source = "../modules/proxmox_network_vlan"

  providers = {
    proxmox = proxmox.second
  }

  base_bridge     = "vmbr10101"
  vlan_name       = "vlan180"
  node_name       = var.pm_second_node_name
  vlan_id         = 180
  comment         = "VLAN network created by Terraform"
}
