terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      #version = "~> 3.27"
    }
  }
  #required_version = ">= 0.13.4"
}

provider "aws" {
  profile = "default"
  region  = "us-east-1"
}

resource "tls_private_key" "private_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "local_file" "private_key" {
  content         = tls_private_key.private_key.private_key_pem
  filename        = "aws_private_key.pem"
  file_permission = "0600"
}
resource "aws_key_pair" "generated_key" {
  key_name   = var.key_name
  public_key = tls_private_key.private_key.public_key_openssh
}

resource "aws_instance" "rancher_cluster" {
  ami                         = var.instance_ami
  instance_type               = var.instance_type
  count                       = var.instance_count
  associate_public_ip_address = false
  private_ip                  = element(var.private_ip_addr, count.index)
  key_name                    = aws_key_pair.generated_key.key_name
  subnet_id                   = aws_subnet.rancher_master.id
  security_groups             = [ aws_security_group.rancher_ingress.id ]
  tags = {
    name = element(var.instance_name, count.index)
  }
}

resource "aws_instance" "cluster_bastion" {
  ami                         = var.instance_ami
  instance_type               = var.instance_type
  associate_public_ip_address = true
  private_ip                  = "10.0.0.5"
  key_name                    = aws_key_pair.generated_key.key_name
  subnet_id                   = aws_subnet.rancher_master.id
  security_groups             = [ aws_security_group.bastion_ingress.id ]
  tags = {
    name = "cluster_bastion"
  }
}
