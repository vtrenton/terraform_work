resource "aws_vpc" "cluster_lan" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support   = true
  tags = {
    name = "cluster_lan"
  }
}

resource "aws_internet_gateway" "rancher_cluster_gw" {
  vpc_id = aws_vpc.cluster_lan.id
  
  tags = {
    name = "cluster_internet_gateway"
  }
}

resource "aws_default_route_table" "cluster_route" {
  default_route_table_id = aws_vpc.cluster_lan.default_route_table_id
  route = [
      {
      cidr_block                 = "0.0.0.0/0"
      gateway_id                 = aws_internet_gateway.rancher_cluster_gw.id
      carrier_gateway_id         = null
      destination_prefix_list_id = null
      egress_only_gateway_id     = null
      instance_id                = null
      ipv6_cidr_block            = null
      local_gateway_id           = null
      nat_gateway_id             = null
      network_interface_id       = null
      transit_gateway_id         = null
      vpc_endpoint_id            = null
      vpc_peering_connection_id  = null

    }
  ]

  tags = {
    name = "rancher_lan_route"
  }
}

resource "aws_subnet" "rancher_master" {
  # vpc + 11 net bits == netsize of 10.0.0.0 to 10.0.0.31 (10.0.0.0/27)
  cidr_block        = cidrsubnet(aws_vpc.cluster_lan.cidr_block, 11, 0)
  vpc_id            = aws_vpc.cluster_lan.id
  availability_zone = "us-east-1a"
  tags = {
    Name = "rancher_lan"
  }
}
