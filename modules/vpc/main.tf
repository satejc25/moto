
resource "aws_vpc" "moto_vpc" {
    cidr_block = var.cidr_block
    tags = {
      Name = "${var.project}-vpc"
      Environment = var.Environment
    }
  
}

resource "aws_internet_gateway" "moto_IGW" {
    vpc_id = aws_vpc.moto_vpc.id
    tags = {
      Name = "motogp-igw"
    }
  
}

resource "aws_route_table" "rt_main" {
  vpc_id = aws_vpc.moto_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.moto_IGW.id
  }
  tags = {
    Name = "rt-main"
  }
  
}

resource "aws_subnet" "public_subnet" {
    vpc_id = aws_vpc.moto_vpc.id
    cidr_block = var.public_subnet_1a
    availability_zone = var.avalability_zone_1a
    map_public_ip_on_launch = true
    tags = {
      Name = "Public-Subnet-1-Motogp"
    }
}

resource "aws_subnet" "private_subnet" {
  vpc_id = aws_vpc.moto_vpc.id
  cidr_block = var.private_subnet_1a
  availability_zone = var.avalability_zone_1a
  tags = {
      Name = "Private-Subnet-1-Motogp"
    }
}

resource "aws_route_table" "moto_private_rt" {
  vpc_id = aws_vpc.moto_vpc.id
  tags = {
    Name = "Motogp-private-rt"
  }
  
}

resource "aws_route_table_association" "Public_subnet_association" {
  subnet_id = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.rt_main.id
  
}

resource "aws_route_table_association" "private_subnet_association" {
  subnet_id = aws_subnet.private_subnet.id
  route_table_id = aws_route_table.moto_private_rt.id
  
}

output "public_subnet_id" {
    value = aws_subnet.public_subnet.id
  
}