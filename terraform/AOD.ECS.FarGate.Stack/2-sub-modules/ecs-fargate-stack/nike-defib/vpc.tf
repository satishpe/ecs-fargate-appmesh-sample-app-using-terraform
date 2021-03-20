# creating VPC
module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "2.63.0" 

  name = var.envPrefixName
  cidr = "10.1.0.0/16"

  azs             = ["${var.region}a","${var.region}b"]

  private_subnets = ["10.1.51.0/24","10.1.52.0/24"]
  public_subnets  = ["10.1.1.0/24","10.1.2.0/24"]

  enable_nat_gateway     = true
  single_nat_gateway     = false
  one_nat_gateway_per_az = true
  enable_dns_hostnames   = true
  tags              = var.tags

  # lifecycle {
  #   create_before_destroy = true
  # }

}

