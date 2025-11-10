# main.tf

terraform {
  required_providers {
    proxmox = {
      source = "telmate/proxmox"
      version = "3.0.2-rc05"
    }
  }
}

# Настройка провайдера Proxmox
provider "proxmox" {
  pm_api_url      = var.proxmox_api_url
  pm_api_token_id = var.proxmox_api_token_id
  pm_api_token_secret = var.proxmox_api_token_secret
  pm_tls_insecure = var.proxmox_tls_insecure
}

# Создание VM из шаблона
resource "proxmox_vm_qemu" "vm_from_template" {
  name        = var.vm_name
  target_node = var.proxmox_node_name
  clone       = var.template_name
  full_clone  = var.proxmox_full_clone

  # Основные параметры VM
  cores = var.vm_cpu_cores
  memory = var.vm_ram_memory

  # Диски
  disk {
    slot    = var.vm_disk_slot
    size    = var.vm_disk_size
    type    = var.vm_disk_type
    storage = var.vm_storage
  }

  # Сеть
  network {
    model  = var.vm_network_model
    bridge = var.vm_network_bridge
  }

  # SSH-ключ для доступа (опционально)
  # sshkeys = file("~/.ssh/id_rsa.pub")

  # Cloud-init (опционально, для настройки ОС)
  # provisioner "remote-exec" можно использовать для выполнения команд после запуска
}
