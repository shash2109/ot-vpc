resource "aws_vpc" "main" {
  cidr_block                       = var.cidr_block
  instance_tenancy                 = var.instance_tenancy
  enable_dns_support               = var.enable_dns_support
  enable_dns_hostnames             = var.enable_dns_hostnames

  tags = merge(
    {
      "Name" = format("%s", var.name)
    },
    var.tags,
  )
}

resource "aws_flow_log" "vpc_flow_logs" {
  count = var.enable_vpc_logs == true ? 1 : 0
  log_destination      = var.logs_bucket
  log_destination_type = var.log_destination_type
  traffic_type         = var.traffic_type
  vpc_id               = aws_vpc.main.id
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id
  tags = merge(
    {
      "Name" = format("%s-igw", var.name)
    },
    var.tags,
  )
}

module "publicRouteTable" {
  source  = "OT-CLOUD-KIT/route-table/aws"
  version = "0.0.1"
  cidr = "0.0.0.0/0"
  gateway_id  = aws_internet_gateway.igw.id
  name        = format("%s-pub-rtb", var.name)
  vpc_id      = aws_vpc.main.id
  tags = var.tags
}

module "PublicSubnets" {
  source  = "OT-CLOUD-KIT/subnet/aws"
  version = "0.0.1"
  availability_zones = var.avaialability_zones
  name = format("%s-pub-sn", var.name)
  route_table_id = module.publicRouteTable.id
  subnets_cidr = var.public_subnets_cidr
  vpc_id      = aws_vpc.main.id
  tags = var.tags
}

#nat-gateway and its private table for aza
module "nat-gateway_aza" {
  source  = "OT-CLOUD-KIT/nat-gateway/aws"
  version = "0.0.1"
  vpc_id = aws_vpc.main.id
  subnets_for_nat_gw = module.PublicSubnets.ids[0]
  route_table_id = module.privateRouteTable_aza.id
  vpc_name = var.name
  tags = var.tags
}

module "privateRouteTable_aza" {
  source  = "OT-CLOUD-KIT/route-table/aws"
  version = "0.0.1"
  cidr = "0.0.0.0/0"
  gateway_id  = module.nat-gateway_aza.ngw_id
  name        = format("%s-pvt-rtb-aza", var.name)
  vpc_id      = aws_vpc.main.id
  tags = var.tags
}

module "PrivateSubnets_aza" {
  source  = "OT-CLOUD-KIT/subnet/aws"
  version = "0.0.1"
  availability_zones = var.avaialability_zones[0]
  name = format("%s-pvt-sn-1", var.name)
  route_table_id = module.privateRouteTable_aza.id
  subnets_cidr = var.private_subnets_cidr[0]
  vpc_id      = aws_vpc.main.id
  tags = var.tags
}

#nat-gateway and its private table for azb
module "nat-gateway_azb" {
  source  = "OT-CLOUD-KIT/nat-gateway/aws"
  version = "0.0.1"
  vpc_id = aws_vpc.main.id
  subnets_for_nat_gw = module.PublicSubnets.ids[1]
  route_table_id = module.privateRouteTable_azb.id
  vpc_name = var.name
  tags = var.tags
}

module "privateRouteTable_azb" {
  source  = "OT-CLOUD-KIT/route-table/aws"
  version = "0.0.1"
  cidr = "0.0.0.0/0"
  gateway_id  = module.nat-gateway_azb.ngw_id
  name        = format("%s-pvt-rtb-azb", var.name)
  vpc_id      = aws_vpc.main.id
  tags = var.tags
}

module "PrivateSubnets_azb" {
  source  = "OT-CLOUD-KIT/subnet/aws"
  version = "0.0.1"
  availability_zones = var.avaialability_zones[1]
  name = format("%s-pvt-sn-2", var.name)
  route_table_id = module.privateRouteTable_azb.id
  subnets_cidr = var.private_subnets_cidr[1]
  vpc_id      = aws_vpc.main.id
  tags = var.tags
}

#nat-gateway and its private table for azc
module "nat-gateway_azc" {
  source  = "OT-CLOUD-KIT/nat-gateway/aws"
  version = "0.0.1"
  vpc_id = aws_vpc.main.id
  subnets_for_nat_gw = module.PublicSubnets.ids[2]
  route_table_id = module.privateRouteTable_azc.id
  vpc_name = var.name
  tags = var.tags
}

module "privateRouteTable_azc" {
  source  = "OT-CLOUD-KIT/route-table/aws"
  version = "0.0.1"
  cidr = "0.0.0.0/0"
  gateway_id  = module.nat-gateway_azc.ngw_id
  name        = format("%s-pvt-rtb-azc", var.name)
  vpc_id      = aws_vpc.main.id
  tags = var.tags
}

module "PrivateSubnets_azc" {
  source  = "OT-CLOUD-KIT/subnet/aws"
  version = "0.0.1"
  availability_zones = var.avaialability_zones[2]
  name = format("%s-pvt-sn-3", var.name)
  route_table_id = module.privateRouteTable_azc.id
  subnets_cidr = var.private_subnets_cidr[2]
  vpc_id      = aws_vpc.main.id
  tags = var.tags
}

module "public_web_security_group" {
  source  = "OT-CLOUD-KIT/security-groups/aws"
  version = "1.0.0"
  enable_whitelist_ip = true
  name_sg = "Public web Security Group"
  vpc_id   = aws_vpc.main.id
  ingress_rule = {
    rules = {
      rule_list = [
          {
              description = "Rule for port 80"
              from_port = 80
              to_port = 80
              protocol = "tcp"
              cidr = ["0.0.0.0/0"]
              source_SG_ID = []
          },
          { 
              description = "Rule for port 443"
              from_port = 443
              to_port = 443
              protocol = "tcp"
              cidr = ["0.0.0.0/0"]
              source_SG_ID = []
          }
      ]
   }
  }
} 

module "pub_alb" {
  source  = "OT-CLOUD-KIT/alb/aws"
  version = "0.0.3"
  alb_name = format("%s-pub-alb", var.name)
  internal = false
  logs_bucket = var.logs_bucket
  security_groups_id = [module.public_web_security_group.sg_id]
  subnets_id = module.PublicSubnets.ids
  tags =var.tags
  enable_logging = var.enable_alb_logging
  enable_deletion_protection = var.enable_deletion_protection
}

resource "aws_route53_zone" "private_hosted_zone" {
  name = var.pvt_zone_name
  vpc {
    vpc_id = aws_vpc.main.id
  }
}

