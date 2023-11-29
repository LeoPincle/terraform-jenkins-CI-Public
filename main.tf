module "project-vpc" {
  source = "./modules/vpc"
  vpc-cidr = var.vpc-cidr
  availability-zone-A = var.availability-zone-A
  availability-zone-B = var.availability-zone-B
}

module "security-groups" {
  source = "./modules/security-groups"
  vpc_id = module.project-vpc.vpc_id
}

module "frontend" {
  source = "./modules/frontend"
  lb_SG_B_id = module.security-groups.lb_SG_B_id
  publicA_id = module.project-vpc.publicA_id
  publicB_id = module.project-vpc.publicB_id
  vpc_id = module.project-vpc.vpc_id
}

module "frontend-launch-template" {
  source = "./modules/frontend-launch-template"
  instance_sg = module.security-groups.instance_sg_id
}

module "backend" {
  source = "./modules/backend"
  lb_SG_B_id = module.security-groups.lb_SG_B_id
  privateA_id = module.project-vpc.privateA_id
  privateB_id = module.project-vpc.privateB_id
  vpc_id = module.project-vpc.vpc_id
}

module "backend-launch-template" {
  source = "./modules/backend-launch-template"
  instance_sg = module.security-groups.instance_sg_id
}

module "asg-frontend" {
  source = "./modules/asg-frontend"
  publicA_id = module.project-vpc.publicA_id
  publicB_id = module.project-vpc.publicB_id
  frontend_tg_arn = module.frontend.frontend_TG_arn
  frontend_launch_id = module.frontend-launch-template.frontend_ltp_id
}

module "asg-frontend-policy" {
  source = "./modules/asg-policy-frontend"
  asg_frontend = module.asg-frontend.asg_frontend_name
}

module "asg-backend" {
  source = "./modules/asg-backend"
  privateA_id = module.project-vpc.privateA_id
  privateB_id = module.project-vpc.privateB_id
  backend_TG_arn = module.backend.backend_TG_arn
  backend_launch_id = module.backend-launch-template.backend_launch_id
}

module "asg-backend-policy" {
  source = "./modules/asg-policy-backend"
  asg_backend = module.asg-backend.asg_backend_name
}
