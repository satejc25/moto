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
