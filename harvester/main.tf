terraform {
  required_providers {
    harvester = {
      source = "harvester/harvester"
      version = "0.2.7"
    }
  }
}

provider "harvester" {
  kubeconfig = "./kubeconfig.yaml"
}

resource "harvester_clusternetwork" "vlan" {
  lifecycle {
    prevent_destroy = true
  }
  name                 = "vlan"
  enable               = true
  default_physical_nic = "eth0"
}
