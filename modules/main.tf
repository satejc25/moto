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
  backend "s3" {                            #backend define where to store tfstate file
    bucket = "motogp-terraform-buckkk"      #in this bucket tfstate file is stored
    key = "terraform.tfstate"               #file to be stored in bucket
    region = "ap-south-1"                   #region to connect with dynamodb table
    dynamodb_table = "motogp-terraform-tf"  #dynamodb table--> terraform generate keynames that includes values of bucket and key variable.... 
    
  }
}

module "motogp-vpc-module" {                #we can put our code in module block and use our code multiple times by changing values from variable.tf file. module contains all the variables declared in code 
    source = "./vpc"                        #source is location of child directory where our resources are stored
    cidr_block = var.cidr_block             #var.cidr block means here the valu is dynamic and it is passed through variable.tf file.  
    project = var.project
    Environment = var.Environment
    public_subnet_1a = var.public_subnet_1a
    public_subnet_1b = var.public_subnet_1b
    avalability_zone_1a = var.avalability_zone_1a
    avail_zone_2a = var.avail_zone_2a
    private_subnet_1a = var.private_subnet_1a
    cidr_ipv4_block = var.cidr_block

}

module "ec2" {
    source = "./ec2"
    instance_count = var.count
    ami_id = var.ami_id
    key_name_global = var.key_name_global
    instance_type_mgp = var.instance_type_mgp
    subnet_id_mgp = module.motogp-vpc-module.public_subnet_id         #here we have called values from module. syntax for calling module is {{module.module_name.output_name}}.. Here output name is important because module calling is based on output block because in output block we have printed our id's arns's and names. 
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
  subnets2_mg = [module.motogp-vpc-module.public_subnet_idb]
  Environment = var.Environment
  
}
module "s3" {
    source = "./s3"
    bucket = var.bucket
    project = var.project
    Environment = var.Environment  
}
