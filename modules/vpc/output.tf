
output "public_subnet_id" {
    value = aws_subnet.public_subnet.id
  
}

output "vpc_security_group_ids" {
    value = aws_security_group.motogp-sg.id
  
}