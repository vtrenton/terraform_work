variable "network_iface" {
  description = "label of the default network interface for the LAN"
  type        = string
  default     = "eno1"
}
variable "kubeconfig" {
  description = "Path to the harvester kubeconfig file"
  type        = string
  default     = "./kubeconfig.yaml"
}
