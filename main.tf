# S3 backend
# terraform {
#   backend "s3" {
#     bucket         = "terraform-series-150903-s3-backend"
#     key            = "develop"
#     region         = "us-east-1"
#     encrypt        = true
#     role_arn       = "arn:aws:iam::471112789042:role/Terraform-Series-150903S3BackendRole"
#     dynamodb_table = "terraform-series-150903-s3-backend"
#   }
# }
# -----------------------------------------------------------------------------------------------

#Remote backend
terraform { 
  cloud { 
    
    organization = "deconbehe-company" 

    workspaces { 
      name = "terraform-remote-backend" 
    } 
  } 
}

provider "aws" {
  region = "us-east-1"
}

module "vpc" {
  source = "Alexeanred/vpc/aws"
  version = "1.0.2"
  vpc_cidr_block    = "10.0.0.0/16"
  private_subnet_cidr    = ["10.0.1.0/24", "10.0.2.0/24"]
  public_subnet_cidr     = ["10.0.3.0/24", "10.0.4.0/24"]
  availability_zone = ["us-east-1a", "us-east-1b"]

}

module "security" {
  source = "./security"
  vpc_id = module.vpc.vpc_id
}

module "compute" {
  source = "./compute"
  public_subnet_id = module.vpc.public_subnet_id
  sg_id = module.security.sg_id
}

# VPC ID, SG ID, instance ID,
output "vpc_id" {
  value = module.vpc.vpc_id
}

output "sg_id" {
  value = module.security.sg_id
}

output "instance_id" {
  value = module.compute.instance_id
}

output "instance_info" {
  value = format("the instance is %s and has key name %s.", module.compute.instance_state, module.compute.key_pair_name)
}

