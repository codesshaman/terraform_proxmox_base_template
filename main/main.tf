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
