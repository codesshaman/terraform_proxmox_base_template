# variables.tf

variable "proxmox_api_url" {
  description = "URL Proxmox API"
  type        = string
}

variable "proxmox_user" {
  description = "Proxmox user name"
  type        = string
  default     = "root"
}

variable "proxmox_tls_insecure" {
  description = "http or https"
  type        = bool
  default     = "true"
}

variable "proxmox_api_token_id" {
  description = "Token ID for Proxmox API"
  type        = string
  sensitive   = true
}

variable "proxmox_api_token_secret" {
  description = "Proxmox API token secret"
  type        = string
  sensitive   = true
}

variable "proxmox_node_name" {
  description = "Proxmox node name"
  type        = string
}

variable "template_name" {
  description = "VM template name"
  type        = string
}

variable "vm_name" {
  description = "VM name"
  type        = string
  default     = "my-vm-from-template"
}
