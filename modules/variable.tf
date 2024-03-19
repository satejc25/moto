variable "region" {
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

variable "private_subnet_1a" {
    description = "cidr block of private subnet"
    type = string
    default = "10.0.2.0/24"
  
}

variable "avalability_zone_1a" {
    description = "avalability of vpc"
    type = string
    default = "us-east-2a"
  
}

variable "s3_bucket" {
    description = "name of s3 bucket provided here"
    type = string
    default = "moto-gp-s3-buckk"
  
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

variable "tg_name" {
    description = "name of target group"
    type = string
    default = "motogp-tg"
  
}

variable "protocol_tg" {
    description = "protocol is declared"
    type = string
    default = "http"
  
}

variable "lb_name" {
    description = "name of load balancer"
    type = string
    default = "motogp-alb"

}

variable "load_balancer_type" {
    description = "type of load balancer"
    type = string
    default = "application"
  
}