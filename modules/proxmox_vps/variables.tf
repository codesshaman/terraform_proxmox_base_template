# variables.tf

variable "description" {
  type        = string
  description = "VM Description"
}

variable "node_name" {
  type        = string
  description = "The name of node"
}

variable "vm_name" {
  type        = string
  description = "The name of virtual machine"
}

variable "username" {
  type        = string
  description = "The name of virtual machine user"
  sensitive   = true
}

variable "password" {
  type        = string
  description = "Password of virtual machine user"
  sensitive   = true
}

variable "datastore" {
  type        = string
  description = "Datastore ID"
}

variable "image_path" {
  type        = string
  description = "Qemu image id (pvesm list local-lvm)"
}

variable "interface" {
  type        = string
  description = "Datastore Name"
  default = "scsi"
}

variable "disk_size" {
  type        = number
  description = "Disk size"
}

variable "ssh_public_key" {
  type        = string
  description = "SSH Public key for login"
  sensitive   = true
}