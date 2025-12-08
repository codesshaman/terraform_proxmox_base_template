# networks.tf

module "proxmox_virtual_environment_vm" {
  source = "../../modules/proxmox_vps"
  description = "Some descr"
  providers = {
    proxmox = proxmox
  }

  vm_name         = "test-vm"
  ssh_public_key  = "~/.ssh/id_rsa.pub"
  node_name       = var.pm_node_name
  username        = "user"
  password        = "1"
  interface       = "scsi0"
  datastore       = "local-lvm"
  image_path      = "local-lvm:base-2013-disk-0"
  disk_size       = 8
}
