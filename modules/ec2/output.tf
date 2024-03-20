output "instance_id" {
    value = aws_instance.moto-ec2[*].id
  
}