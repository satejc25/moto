output "subnet_id_private" {
  value = "aws_subnet.private_subnet"
}

output "subnet_id_public" {
  value = "aws_subnet.public_subnet"
}

output "vpc_id" {
  value = aws_vpc.moto_vpc.id
}

# It is not neccessory to use call the both o/p, we call it according to requirement