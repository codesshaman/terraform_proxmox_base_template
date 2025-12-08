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


provider "proxmox" {
  endpoint  = var.pm_node_api_url
  api_token = "${var.pm_node_api_token_id}=${var.pm_node_api_token_secret}"
  insecure  = var.proxmox_tls_insecure
}
