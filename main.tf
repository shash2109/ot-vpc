resource "aws_eip" "nat_ip1" {  
  vpc = true
}

resource "aws_eip" "nat_ip2" {
  vpc = true
}

resource "aws_eip" "nat_ip3" {
  vpc = true
}

resource "aws_nat_gateway" "nat_gw1" {
  allocation_id = aws_eip.nat_ip1.id
  subnet_id     = var.subnets_for_nat_gw[0]
  tags = merge(
    {
      Name = format("%s-nat", var.vpc_name)
    },
    var.tags,
  )
}

resource "aws_nat_gateway" "nat_gw2" {
  allocation_id = aws_eip.nat_ip2.id
  subnet_id     = var.subnets_for_nat_gw[1]
  tags = merge(
    {
      Name = format("%s-nat", var.vpc_name)
    },
    var.tags,
  )
}

resource "aws_nat_gateway" "nat_gw3" {
  allocation_id = aws_eip.nat_ip3.id
  subnet_id     = var.subnets_for_nat_gw[2]
  tags = merge(
    {
      Name = format("%s-nat", var.vpc_name)
    },
    var.tags,
  )
}

resource "aws_route_table" "route_table2" {
  vpc_id = var.vpc_id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.nat_gw2.id
  }

  tags = {
  
  "Name" = "pvt-rtb2"
}
}

resource "aws_route_table" "route_table3" {
  vpc_id = var.vpc_id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.nat_gw2.id
  }

  tags = {
      "Name" = "pvt-rtb3"
  }
}

resource "aws_route_table_association" "route_table_association2" {
  subnet_id      = var.subnets_for_nat_gw[1]
  route_table_id = aws_route_table.route_table2.id
}

resource "aws_route_table_association" "route_table_association3" {
  subnet_id      = var.subnets_for_nat_gw[2]
  route_table_id = aws_route_table.route_table3.id
}
