data "aws_availability_zones" "available" {
  state = "available"
}

module "vpc" {
  source                                                        = "terraform-aws-modules/vpc/aws"
  name                                                          = "${var.network_name}-vpc"
  cidr                                                          = var.vpc_CIDR_block
  azs                                                           = [data.aws_availability_zones.available.names[0], data.aws_availability_zones.available.names[1]]
  private_subnets                                               = [var.private_subnet_a_CIDR_block, var.private_subnet_b_CIDR_block]
  public_subnets                                                = [var.public_subnet_a_CIDR_block, var.public_subnet_b_CIDR_block]
  enable_ipv6                                                   = var.enable_ipv6
  enable_nat_gateway                                            = var.enable_nat_gateway
  single_nat_gateway                                            = var.single_nat_gateway
  one_nat_gateway_per_az                                        = var.one_nat_gateway_per_az
  enable_dns_hostnames                                          = var.enable_dns_hostnames
  enable_dns_support                                            = var.enable_dns_support
  public_subnet_tags                                            = var.tags
  private_subnet_enable_dns64                                   = false
  public_subnet_enable_dns64                                    = false
  public_subnet_enable_resource_name_dns_aaaa_record_on_launch  = false
  private_subnet_enable_resource_name_dns_aaaa_record_on_launch = false
  map_public_ip_on_launch                                       = true
  vpc_tags                                                      = var.tags
}

