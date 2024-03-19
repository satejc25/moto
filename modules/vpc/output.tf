
output "public_subnet_id" {                  #here in output block "public_subnet_id" is random name which is known as output name. By using value we have printed public subnet id.  
    value = aws_subnet.public_subnet.id
  
}

output "public_subnet_idb" {                #here also subnet id is printed
    value = aws_subnet.public_subnet_b.id
  
}

output "security_groups" {                  #here security group id is printed
    value = aws_security_group.motogp-sg.id
  
}

output "sg_vpc_id" {
    value = aws_vpc.moto_vpc.id
  
}
