variable "instance_ami" {
  default = "ami-08895422b5f3aa64a"
}
variable "instance_type" {
  default = "t2.medium"
}
variable "instance_count" {
  default = 3
}
variable "instance_name" {
  description = "Value of the name tag for the EC2 instance"
  type        = list
  default     = ["rancher_node-1", "rancher_node-2", "rancher_node-3"]
}
variable "key_name" {
  description = "Value of the key name used for ssh access to instance"
  type        = string
  default     = "rancher_access_key"
}
variable "private_ip_addr" {
  description = "list of ip private addresses to be assigned to the host"
  type        = list
  default     = ["10.0.0.11", "10.0.0.12", "10.0.0.13"]
}
