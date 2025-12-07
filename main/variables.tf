# variables.tf

# All available Proxmox nodes

variable "pm_first_node_name" {
  description = "First proxmox node name"
  default     = "proxmox1"
  type        = string
}

variable "pm_second_node_name" {
  description = "Second proxmox node name"
  default     = "proxmox2"
  type        = string
}

variable "pm_first_node_api_url" {
  description = "First Proxmox node API URL"
  type        = string
}

variable "pm_second_node_api_url" {
  description = "Second Proxmox node API URL"
  type        = string
}

variable "pm_first_node_user" {
  description = "Proxmox first node user name"
  type        = string
  default     = "root"
}

variable "pm_second_node_user" {
  description = "Proxmox second node user name"
  type        = string
  default     = "root"
}

variable "proxmox_tls_insecure" {
  description = "http or https"
  type        = bool
  default     = true
}

# Proxmox secrets

variable "pm_first_node_api_token_id" {
  description = "Token ID for Proxmox API"
  type        = string
  sensitive   = true
}

variable "pm_second_node_api_token_id" {
  description = "Token ID for Proxmox API"
  type        = string
  sensitive   = true
}

variable "pm_first_node_api_token_secret" {
  description = "Proxmox API token secret"
  type        = string
  sensitive   = true
}

variable "pm_second_node_api_token_secret" {
  description = "Proxmox API token secret"
  type        = string
  sensitive   = true
}
