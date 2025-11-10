# main.tf

terraform {
  required_providers {
    proxmox = {
      source  = "telmate/proxmox"
      version = "~> 3.0" # Убедитесь, что используете подходящую версию
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
  full_clone  = true # Создать полную копию шаблона (не Linked Clone)

  # Основные параметры VM
  cores = 2
  memory = 2048

  # Диски
  disk {
    slot    = 0
    size    = "20G"
    type    = "scsi"
    storage = "local-lvm" # Укажите подходящее хранилище
  }

  # Сеть
  network {
    model  = "virtio"
    bridge = "vmbr0" # Укажите подходящий мост
  }

  # SSH-ключ для доступа (опционально)
  # sshkeys = file("~/.ssh/id_rsa.pub")

  # Cloud-init (опционально, для настройки ОС)
  # provisioner "remote-exec" можно использовать для выполнения команд после запуска
}