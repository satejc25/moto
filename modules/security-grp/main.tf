# resource "aws_security_group" "motogp-sg" {
#     name = "${var.project}-vpc"
#     description = "allow inbound and outbound traffic"
#     vpc_id = var.sg_vpc_id
#     tags = {
#      Name = "allow_tls"
#   }
  
# }

# resource "aws_vpc_security_group_ingress_rule" "allow_tls_ipv4" {
#   security_group_id = aws_security_group.motogp-sg.id
#   cidr_ipv4         = var.cidr_ipv4_block
#   from_port         = 443
#   ip_protocol       = "tcp"
#   to_port           = 443
# }

# resource "aws_vpc_security_group_ingress_rule" "allow_ssh_ipv4" {
#   security_group_id = aws_security_group.motogp-sg.id
#   cidr_ipv4         = var.cidr_ipv4_block
#   from_port         = 22
#   ip_protocol       = "tcp"
#   to_port           = 22
# }

# resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ipv4" {
#   security_group_id = aws_security_group.motogp-sg.id
#   cidr_ipv4         = "0.0.0.0/0"
#   ip_protocol       = "-1" # semantically equivalent to all ports
# }

