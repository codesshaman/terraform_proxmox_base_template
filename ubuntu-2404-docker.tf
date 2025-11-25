
# VM creation from template
locals {
  public_ip = "192.168.1.115"
}


resource "proxmox_vm_qemu" "vm_from_template" {
  vmid        = 120
  name        = "test-vm"
  target_node = "proxmox2"
  clone       = "tmp-ubuntu-cloudinit-noble"
  full_clone  = true
  ipconfig0 = "ip=192.168.1.115/24,gw=192.168.1.1"

# Hardware
  cpu {
    cores = var.vm_cpu_cores
  }

  memory = var.vm_ram_memory
  bios            = "seabios"
  scsihw          = "virtio-scsi-single"
  boot            = "order=scsi0;net0"
  bootdisk        = "scsi0"
  # Disks
  disk {
    type    = "disk"
    slot    = "scsi0"
    size    = "8G"
    storage = "local-lvm"
  }

  # Network
  network {
    id     = 0
    model  = "virtio"
    bridge = "vmbr0"
  }

  # SSH-key for cloud-init
  sshkeys = file("~/.ssh/id_rsa.pub")

  provisioner "local-exec" {
    command = "sleep 60"
}

  # Cloud-init
  provisioner "remote-exec" {
    inline = [
      "sudo apt update -y",
      "sudo apt install -y nginx",
      "echo 'Hello from Terraform' | sudo tee /var/www/html/index.html"
    ]

    connection {
      type        = "ssh"
      user        = "user"
      private_key = file("~/.ssh/id_rsa")
    #   host = data.proxmox_vm_qemu.vm_info.ipv4_addresses[0]
      host        = local.public_ip
    }
  }


}
