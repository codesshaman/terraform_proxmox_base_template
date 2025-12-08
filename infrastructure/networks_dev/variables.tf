# variables.tf

# All available Proxmox nodes

variable "pm_node_name" {
  description = "First proxmox node name"
  default     = "proxmox1"
  type        = string
}

variable "pm_node_api_url" {
  description = "First Proxmox node API URL"
  type        = string
}

variable "proxmox_tls_insecure" {
  description = "http or https"
  type        = bool
  default     = true
}

variable "pm_node_alias" {
  description = "Alias for Proxmox provider"
  type        = string
  default     = "default"
}

variable "pm_node_comment" {
  description = "Comment for Proxmox provider"
  type        = string
  default     = "default"
}

# Proxmox secrets

variable "pm_node_api_token_id" {
  description = "Token ID for Proxmox API"
  type        = string
  sensitive   = true
}

variable "pm_node_api_token_secret" {
  description = "Proxmox API token secret"
  type        = string
  sensitive   = true
}
