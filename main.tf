# Tenacity IT Group (TIG) VPC
resource "aws_vpc" "TIG-VPC" {
  cidr_block           = var.vpc_cidr
  instance_tenancy     = var.vpc_tenancy
  enable_dns_hostnames = var.vpc_hostname_toggle


  tags = {
    Name        = var.vpc_name
    Environment = var.flexible
  }
}

# First public subnet
resource "aws_subnet" "Prod-pub-sub1" {
  vpc_id            = aws_vpc.TIG-VPC.id
  cidr_block        = var.public_subnet_1_cidr
  availability_zone = var.az-1


  tags = {
    Name        = var.public_subnet_1_name
    Environment = var.flexible
  }
}


# Second public subnet
resource "aws_subnet" "Prod-pub-sub2" {
  vpc_id            = aws_vpc.TIG-VPC.id
  cidr_block        = var.public_subnet_2_cidr
  availability_zone = var.az-2

  tags = {
    Name        = var.public_subnet_2_name
    Environment = var.flexible
  }
}


# First private subnet
resource "aws_subnet" "Prod-priv-sub1" {
  vpc_id            = aws_vpc.TIG-VPC.id
  cidr_block        = var.private_subnet_1_cidr
  availability_zone = var.az-3

  tags = {
    Name        = var.private_subnet_1_name
    Environment = var.flexible
  }
}


# Second private subnet
resource "aws_subnet" "Prod-priv-sub2" {
  vpc_id            = aws_vpc.TIG-VPC.id
  cidr_block        = var.private_subnet_2_cidr
  availability_zone = var.az-4

  tags = {
    Name        = var.private_subnet_2_name
    Environment = var.flexible
  }
}


# Public route table
resource "aws_route_table" "Prod-pub-route-table" {
  vpc_id = aws_vpc.TIG-VPC.id

  tags = {
    Name        = var.public_route_table
    Environment = var.flexible
  }
}


# Private route table
resource "aws_route_table" "Prod-priv-route-table" {
  vpc_id = aws_vpc.TIG-VPC.id

  tags = {
    Name        = var.private_route_table
    Environment = var.flexible
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
    Name        = var.IGW
    Environment = var.flexible
  }
}


# Associating Internet gateway with the public route table
resource "aws_route" "Prod-igw-association" {
  route_table_id         = aws_route_table.Prod-pub-route-table.id
  destination_cidr_block = var.IGW_cidr
  gateway_id             = aws_internet_gateway.Prod-igw.id

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
    Name        = var.NGW
    Environment = var.flexible
  }
}


# Associating NAT gateway with the private route table
resource "aws_route" "Prod-Nat-association" {
  route_table_id         = aws_route_table.Prod-priv-route-table.id
  destination_cidr_block = var.NGW_cidr
  gateway_id             = aws_nat_gateway.Prod-Nat-gateway.id
}