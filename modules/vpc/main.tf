
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

resource "aws_subnet" "public_subnet_b" {
    vpc_id = aws_vpc.moto_vpc.id
    cidr_block = var.public_subnet_1b
    availability_zone = var.avail_zone_2a
    map_public_ip_on_launch = true
    tags = {
      Name = "Public Subnet-2"
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

resource "aws_route_table_association" "Public_subnet_associationb" {
  subnet_id = aws_subnet.public_subnet_b.id
  route_table_id = aws_route_table.rt_main.id
  
}

resource "aws_route_table_association" "private_subnet_association" {
  subnet_id = aws_subnet.private_subnet.id
  route_table_id = aws_route_table.moto_private_rt.id
  
}

#creating security group

resource "aws_security_group" "motogp-sg" {
    name = "${var.project}-vpc"
    description = "allow inbound and outbound traffic"
    vpc_id = aws_vpc.moto_vpc.id
    tags = {
     Name = "allow_tls"
  }
  
}

resource "aws_vpc_security_group_ingress_rule" "allow_tls_ipv4" {
  security_group_id = aws_security_group.motogp-sg.id
  cidr_ipv4         = var.cidr_ipv4_block
  from_port         = 443
  ip_protocol       = "tcp"
  to_port           = 443
}

resource "aws_vpc_security_group_ingress_rule" "allow_ssh_ipv4" {
  security_group_id = aws_security_group.motogp-sg.id
  cidr_ipv4         = var.cidr_ipv4_block
  from_port         = 22
  ip_protocol       = "tcp"
  to_port           = 22
}

resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ipv4" {
  security_group_id = aws_security_group.motogp-sg.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
}

