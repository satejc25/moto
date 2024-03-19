terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.41.0"
    }
  }
}

provider "aws" {
  region = var.region
  shared_config_files = ["/home/ubuntu/.aws/config"]
  shared_credentials_files = ["/home/ubuntu/.aws/credentials"]
  profile = var.profile
  
}

terraform {
  backend "s3" {
    bucket = "motogp-terraform-buckkk"
    key = "terraform.tfstate"
    region = "ap-south-1"
    dynamodb_table = "motogp-terraform-tf"
    
  }
}

module "motogp-vpc-module" {
    source = "./vpc"
    cidr_block = var.cidr_block
    project = var.project
    Environment = var.Environment
    public_subnet_1a = var.public_subnet_1a
    avalability_zone_1a = var.avalability_zone_1a
    private_subnet_1a = var.private_subnet_1a
    cidr_ipv4_block = var.cidr_block

}

module "ec2" {
    source = "./ec2"
    ami_id = var.ami_id
    key_name_global = var.key_name_global
    instance_type_mgp = var.instance_type_mgp
    subnet_id_mgp = module.motogp-vpc-module.public_subnet_id
    vpc_security_group_ids = module.motogp-vpc-module.vpc_security_group_ids
    project = var.project
    Environment = var.Environment

}