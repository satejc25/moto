variable "region" {                           #here in all variable blocks variable name is provided and value for that name is given. 
    description = "region "
    type = string
    default = "us-east-2"
  
}

variable "profile" {
    description = "profile of aws user"
    type = string
    default = "satej"
  
}

variable "cidr_block" {
    description = "cidr block for motogp vpc"
    type = string
    default = "10.0.0.0/16"
  
}

variable "project" {
    description = "Name of project"
    type = string
    default = "MOTO-GP"
  
}

variable "Environment" {
    description = "Environment of vpc"
    type = string
    default = "Staging"
  
}

variable "public_subnet_1a" {
    description = "cidr block of public subnet"
    type = string
    default = "10.0.1.0/24"
  
}


variable "public_subnet_1b" {
    description = "cidr block of private subnet"
    type = string
    default = "10.0.2.0/24"
  
}

variable "private_subnet_1a" {
    description = "cidr block of private subnet"
    type = string
    default = "10.0.3.0/24"
  
}


variable "avalability_zone_1a" {
    description = "avalability of vpc"
    type = string
    default = "us-east-2a"
  
}

variable "avail_zone_2a" {
    description = "avalability of vpc"
    type = string
    default = "us-east-2b"
  
}

variable "ami_id" {
    description = "ami-id of ubuntu instance"
    type = string
    default = "ami-0b8b44ec9a8f90422"
  
}

variable "instance_type_mgp" {
    description = "type of instance is described"
    type = string
    default = "t2.micro"
  
}

variable "key_name_global" {
    description = "key value pair to take ssh"
    type = string
    default = "windows_global_key"
  
}

variable "bucket" {
    description = "Bucket Name"
    type = string
    default = "motogp-buckett"
  
}

variable "tg_name" {
    description = "target group name"
    type = string
    default = "MotoGP-TG"
  
}

variable "protocol_tg" {
    description = "protocol used in tg"
    type = string
    default = "HTTP"
  
}

variable "lb_name" {
    description = "load balancer name"
    type = string
    default = "MotoGP-ALB"

  
}

variable "load_balancer_type" {
    description = "type of load balancer"
    type = string
    default = "application"
  
}