terraform {
  required_providers {
    libvirt = {
      source = "dmacvicar/libvirt"
    }
  }
}

provider "libvirt" {
  uri = "qemu:///system"
}

resource "libvirt_domain" "ubuntu_rke" {
  name   = var.machine_name
  memory = var.host_mem
  
}
