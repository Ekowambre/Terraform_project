# Tenacity IT Group (TIG) VPC
resource "aws_vpc" "TIG-VPC" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "TIG-VPC"
  }
}


# First public subnet
resource "aws_subnet" "Prod-pub-sub1" {
  vpc_id     = aws_vpc.TIG-VPC.id
  cidr_block = "10.0.1.0/24"

  tags = {
    Name = "Prod-pub-sub1"
  }
}


# Second public subnet
resource "aws_subnet" "Prod-pub-sub2" {
  vpc_id     = aws_vpc.TIG-VPC.id
  cidr_block = "10.0.2.0/24"

  tags = {
    Name = "Prod-pub-sub2"
  }
}


# First private subnet
resource "aws_subnet" "Prod-priv-sub1" {
  vpc_id     = aws_vpc.TIG-VPC.id
  cidr_block = "10.0.3.0/24"

  tags = {
    Name = "Tmt-priv-sub1"
  }
}


# Second private subnet
resource "aws_subnet" "Prod-priv-sub2" {
  vpc_id     = aws_vpc.TIG-VPC.id
  cidr_block = "10.0.4.0/24"

  tags = {
    Name = "Prod-priv-sub2"
  }
}


# Public route table
resource "aws_route_table" "Prod-pub-route-table" {
  vpc_id = aws_vpc.TIG-VPC.id

  tags = {
    Name = "Prod-pub-route-table"
  }
}


# Private route table
resource "aws_route_table" "Prod-priv-route-table" {
  vpc_id = aws_vpc.TIG-VPC.id

  tags = {
    Name = "Prod-priv-route-table"
  }
}


# First public route table association
resource "aws_route_table_association" "Prod-pub-route-association-1" {
  subnet_id      = aws_subnet.Prod-pub-sub1.id
  route_table_id = aws_route_table.Prod-pub-route-table.id
}


# Second public route table association
resource "aws_route_table_association" "Prod-pub-route-association-2" {
  subnet_id      = aws_subnet.Prod-pub-sub2.id
  route_table_id = aws_route_table.Prod-pub-route-table.id
}


# First private route table association
resource "aws_route_table_association" "Prod-priv-route-association-1" {
  subnet_id      = aws_subnet.Prod-priv-sub1.id
  route_table_id = aws_route_table.Prod-priv-route-table.id
}


# Second private route table association
resource "aws_route_table_association" "Prod-priv-route-association-2" {
  subnet_id      = aws_subnet.Prod-priv-sub2.id
  route_table_id = aws_route_table.Prod-priv-route-table.id
}


# Internet gateway
resource "aws_internet_gateway" "Prod-igw" {
  vpc_id = aws_vpc.TIG-VPC.id

  tags = {
    Name = "Prod-igw"
  }
}


# Associating Internet gateway with the public route table
resource "aws_route" "Prod-igw-association" {
  route_table_id            = aws_route_table.Prod-pub-route-table.id
  destination_cidr_block    = "0.0.0.0/0"
  gateway_id = aws_internet_gateway.Prod-igw.id

  }


# Allocation of Elastic IP
resource "aws_eip" "TIG-EIP" {
# Chose not to use "depends_on" condition
}


  # NAT Gateway
  resource "aws_nat_gateway" "Prod-Nat-gateway" {
  allocation_id = aws_eip.TIG-EIP.id
  subnet_id     = aws_subnet.Prod-pub-sub1.id

  tags = {
    Name = "Prod-Nat-gateway"
  }
  }


  # Associating NAT gateway with the private route table
  resource "aws_route" "Prod-Nat-association" {
  route_table_id            = aws_route_table.Prod-priv-route-table.id
  destination_cidr_block    = "0.0.0.0/0"
  gateway_id = aws_nat_gateway.Prod-Nat-gateway.id
  }