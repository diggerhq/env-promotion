provider "aws" {
  region = var.aws_region
}

module "demo_vpc" {
  source                 = "./demo_vpc"
  network_name           = "demo-vpc"
  region                 = var.aws_region
  enable_nat_gateway     = false
  one_nat_gateway_per_az = false
  tags                   = var.tags
}

module "demo_web" {
  source                 = "./demo_web"
  vpc_id                 = module.demo_vpc.vpc_id
  ecs_service_name       = "demo-web-${var.env_name}"
  alb_subnet_ids         = module.demo_vpc.public_subnets
  ecs_subnet_ids         = module.demo_vpc.public_subnets
  ecs_cluster_name       = "demo-web-${var.env_name}"
  lb_ssl_certificate_arn = aws_acm_certificate.cloud_web_acm_certificate.arn
  container_port         = 3000
  task_cpu               = 256
  task_memory            = 512
  internal               = false
  health_check           = "/"
  health_check_matcher   = "200-499"
  environment_variables  = local.cloud_web_envs
  secrets                = local.cloud_web_secrets
  region                 = var.aws_region
  tags                   = { "created_by" = "digger", }
}

