# modules/proxmox_network_vlan/variables.tf

variable "node_name" {
    type    = string
    default = "proxmox2"
}

variable "vlan_id" {
    type = number
    default = 99
}

variable "base_bridge" {
    type    = string
    default = ""
}

variable "interface" {
    type = string
    default = "vmbr0"
}

variable "vlan_name" {
    type    = string
    default = "vlan99"
}

variable "comment" {
    type    = string
    default = ""
}
