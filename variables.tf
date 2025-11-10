# variables.tf

# Proxmox parameters

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

variable "proxmox_provider_version" {
  description = "Proxmox provider version"
  type        = string
  default     = "3.0.2-rc05"
}

# Proxmox secrets

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

# Proxmox vms

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

variable "proxmox_full_clone" {
  description = "Full clone creation"
  type        = bool
  default     = "true"
}

# VM hardware

variable "vm_cpu_cores" {
  description = "VM CPU cores number"
  type        = number
  default     = 2
}

variable "vm_ram_memory" {
  description = "VM RAM memory size"
  type        = number
  default     = 2048
}

variable "vm_disk_slot" {
  description = "VM disk slot number"
  type        = number
  default     = 0
}

variable "vm_disk_size" {
  description = "VM disk size"
  type        = string
  default     = "16G"
}

variable "vm_disk_type" {
  description = "VM disk type"
  type        = string
  default     = "scsi"
}

variable "vm_storage" {
  description = "VM disk storage"
  type        = string
  default     = "local-lvm"
}

# VM network

variable "vm_network_model" {
  description = "VM network model"
  type        = string
  default     = "virtio"
}

variable "vm_network_bridge" {
  description = "VM network bridge"
  type        = string
  default     = "vmbr0"
}
