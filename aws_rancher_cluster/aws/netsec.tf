resource "aws_security_group" "rancher_ingress" {
  name        = "allow_traffic"
  description = "allow rancher traffic to lan"
  vpc_id      = aws_vpc.cluster_lan.id

  ingress = [
    {
      description      = "allow icmp"
      from_port        = -1
      to_port          = -1
      protocol         = "icmp"
      prefix_list_ids  = null
      security_groups  = null
      self             = null
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = ["::/0"]  
    },
    {
      description      = "allow ssh"
      from_port        = 22
      to_port          = 22
      protocol         = "tcp"
      prefix_list_ids  = null
      security_groups  = null
      self             = null
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = ["::/0"] 
    },
    {
      description = "allow http"
      from_port   = 80
      to_port     = 80
      protocol    = "tcp"
      prefix_list_ids  = null
      security_groups  = null
      self             = null
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = ["::/0"]

    },
    {
      description = "allow https"
      from_port   = 443
      to_port     = 443
      protocol    = "tcp"
      prefix_list_ids  = null
      security_groups  = null
      self             = null
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = ["::/0"] 
    },
    {
      description = "allow etcd ports"
      from_port   = 2379
      to_port     = 2379
      protocol    = "tcp"
      prefix_list_ids  = null
      security_groups  = null
      self             = null
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = ["::/0"] 
    },
    {
      description = "allow etcd ports"
      from_port   = 2380
      to_port     = 2380
      protocol    = "tcp"
      prefix_list_ids  = null
      security_groups  = null
      self             = null
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = ["::/0"] 
    },
    {
      description = "allow kubeapi"
      from_port   = 6443
      to_port     = 6443
      protocol    = "tcp"
      prefix_list_ids  = null
      security_groups  = null
      self             = null
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = ["::/0"] 
    },
    {
      description = "allow kube node registration"
      from_port   = 9345
      to_port     = 9345
      protocol    = "tcp"
      prefix_list_ids  = null
      security_groups  = null
      self             = null
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = ["::/0"] 
    },
  ]
  egress = [
    {
      description      = "add back allow all egress"
      from_port        = 0
      to_port          = 0
      protocol         = "-1"
      prefix_list_ids  = null
      security_groups  = null
      self             = null
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = ["::/0"]
    }
  ]
}
