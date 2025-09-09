provider "aws" {
  region = "ap-south-1"
}

module "security" {
  source  = "./modules/security"
  vpc_id  = var.vpc_id
}

module "ec2" {
  source             = "./modules/ec2"
  ami_id             = var.ami_id
  instance_type      = "t2.micro"
  subnet_id          = var.subnet_id
  security_group_id  = module.security.security_group_id
  key_name           = var.key_name
}

module "alb" {
  source             = "./modules/alb"
  security_group_id  = module.security.security_group_id
  subnet_ids         = var.subnet_ids
  vpc_id             = var.vpc_id
  instance_id        = module.ec2.instance_id
}
