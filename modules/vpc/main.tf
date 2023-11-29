resource aws_vpc "project_vpc"{
  cidr_block = var.vpc-cidr

  tags = {
    "Name" = "project_vpc"
  }
}

resource aws_subnet "project_publicA" {
  vpc_id = aws_vpc.project_vpc.id
  cidr_block = cidrsubnet(aws_vpc.project_vpc.cidr_block, 8, 0)
  availability_zone = var.availability-zone-A

  tags = {
    "Name" = "project_publicA"
  }
}

resource aws_subnet "project_privateA"{
  vpc_id = aws_vpc.project_vpc.id
  cidr_block = cidrsubnet(aws_vpc.project_vpc.cidr_block, 8, 1)
  availability_zone = var.availability-zone-A

  tags = {
    "Name" = "project_privateA"
  }
}

resource aws_subnet "project_publicB" {
  vpc_id = aws_vpc.project_vpc.id
  cidr_block = cidrsubnet(aws_vpc.project_vpc.cidr_block, 8, 2)
  availability_zone = var.availability-zone-B

  tags = {
    "Name" = "project_publicB"
  }
}

resource aws_subnet "project_privateB"{
  vpc_id = aws_vpc.project_vpc.id
  cidr_block = cidrsubnet(aws_vpc.project_vpc.cidr_block, 8, 3)
  availability_zone = var.availability-zone-B

  tags = {
    "Name" = "project_privateB"
  }
}

resource "aws_internet_gateway" "project_igw" {
  vpc_id = aws_vpc.project_vpc.id

  tags = {
    "Name" = "project_igw"
  }
}

resource "aws_route_table" "project_rtb" {
  vpc_id = aws_vpc.project_vpc.id

  tags = {
    "Name" = "project_rtb"
  }
}

resource "aws_route" "project_rt" {
  route_table_id = aws_route_table.project_rtb.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id = aws_internet_gateway.project_igw.id

}

resource "aws_route_table_association" "project_rtb_assoc1" {
  subnet_id = aws_subnet.project_publicA.id
  route_table_id = aws_route_table.project_rtb.id
}

resource "aws_route_table_association" "project_rtb_assoc2" {
  subnet_id = aws_subnet.project_publicB.id
  route_table_id = aws_route_table.project_rtb.id
}

resource "aws_eip" "Nat-Gateway-EIP" {
  depends_on = [
    aws_route_table_association.project_rtb_assoc1
  ]
  vpc = true
}

resource "aws_nat_gateway" "cloudNAT" {
  depends_on = [
    aws_eip.Nat-Gateway-EIP
  ]
  allocation_id = aws_eip.Nat-Gateway-EIP.id
  subnet_id = aws_subnet.project_publicA.id
  tags = {
    Name = "NAT-1"
  }
}

resource "aws_route_table" "NAT-Gateway-RT" {
  depends_on = [
    aws_nat_gateway.cloudNAT
  ]
  vpc_id = aws_vpc.project_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.cloudNAT.id
  }

  tags = {
    Name = "RT for NAT-Gw"
  }
}

resource "aws_route_table_association" "Nat-Gw-RT-AssociationA" {
  depends_on = [
    aws_route_table.NAT-Gateway-RT
  ]
  subnet_id      = aws_subnet.project_privateA.id
  route_table_id = aws_route_table.NAT-Gateway-RT.id
}

resource "aws_route_table_association" "Nat-Gw-RT-AssociationB" {
  depends_on = [
    aws_route_table.NAT-Gateway-RT
  ]
  subnet_id      = aws_subnet.project_privateB.id
  route_table_id = aws_route_table.NAT-Gateway-RT.id
}
