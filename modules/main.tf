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
    security_groups = [module.motogp-vpc-module.security_groups]
    project = var.project
    Environment = var.Environment
    # security_groups_ids = [module.motogp-vpc-module.sg_vpc_id]
}

module "load-balancer" {
  source = "./alb"
  tg_name = var.tg_name
  protocol_tg = var.protocol_tg
  vpc_id_tg = module.motogp-vpc-module.sg_vpc_id
  target_id_ec2 = module.ec2.instance_id
  lb_name = var.lb_name
  load_balancer_type = var.load_balancer_type
  security_groups_mg = [module.motogp-vpc-module.security_groups]
  subnets_mg = [module.motogp-vpc-module.public_subnet_id]
  Environment = var.Environment
  
}
module "s3" {
    source = "./s3"
    bucket = var.bucket
    project = var.project
    Environment = var.Environment  
}
