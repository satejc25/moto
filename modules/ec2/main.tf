resource "aws_instance" "moto-ec2" {
    ami = var.ami_id
    key_name = var.key_name_global
    instance_type = var.instance_type_mgp
    subnet_id = var.subnet_id_mgp
    tags = {
      Name = "${var.project}"
      Environment = var.Environment
    }
    security_groups = var.security_groups
}