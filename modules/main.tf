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
}

module "moto-sg" {
  source = "./security-grp"
  project = var.project
  sg_vpc_id =  module.motogp-vpc-module.vpc_id
  cidr_ipv4_block =var.cidr_block
      
}

module "moto-s3" {
  source = "./s3"
  s3_bucket = var.s3_bucket
  Environment = var.Environment
  
}

module "ec2-mgp" {
  source = "./instance"
  ami_id = var.ami_id
  key_name_global = var.key_name_global
  instance_type_mgp = var.instance_type_mgp
  subnet_id_mgp = module.motogp-vpc-module.public_subnet_id
  project = var.project
  Environment = var.Environment
  vpc_security_group_ids_motogp = [module.moto-sg.security_group_id]

}

# module "motogp-alb" {
  source = "./loadbalancer"
  tg_name = var.tg_name
  protocol_tg = var.protocol_tg
  vpc_id_tg = module.motogp-vpc-module.vpc_id
  target_id_ec2 = module.ec2-mgp.instance_id
  lb_name = var.lb_name
  load_balancer_type = var.load_balancer_type
  security_groups_mg = [module.moto-sg.security_group_id]
  subnets_mg = module.motogp-vpc-module.public_subnet_id
  Environment = var.Environment
  
}
