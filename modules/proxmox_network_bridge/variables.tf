# modules/proxmox_network_bridge/variables.tf

variable "node_name" {
    type    = string
    default = "proxmox2"
}

variable "vlan_id" {
    type = number
    default = 99
}

variable "interface" {
    type = string
    default = "vmbr0"
}

variable "bridge_name" {
    type    = string
    default = "vmbr"
}

variable "bridge_address" {
    type = string
}

variable "comment" {
    type    = string
    default = ""
}
