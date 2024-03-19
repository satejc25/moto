
output "public_subnet_id" {
    value = aws_subnet.public_subnet.id
  
}

output "security_groups" {
    value = aws_security_group.motogp-sg.id
  
}

output "vpc_id" {
    value = aws_vpc.moto_vpc.id
  
}