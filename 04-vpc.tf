# Create a VPC and subnet for the instance
resource "aws_vpc" "stark" {
  cidr_block = "10.22.0.0/16"
  tags       = var.tags
}

resource "aws_subnet" "snow" {
  vpc_id     = aws_vpc.stark.id
  cidr_block = "10.22.11.0/24"

  tags = {
    Name = "snow-subnet"
  }
}

# Create Internet Gateway
resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.stark.id
  tags   = var.tags
}

# Create Route Table
resource "aws_route_table" "bear_island" {
  vpc_id = aws_vpc.stark.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }

  tags = var.tags
}

# Associate Route Table with Subnet
resource "aws_route_table_association" "mormont" {
  subnet_id      = aws_subnet.snow.id
  route_table_id = aws_route_table.bear_island.id
}