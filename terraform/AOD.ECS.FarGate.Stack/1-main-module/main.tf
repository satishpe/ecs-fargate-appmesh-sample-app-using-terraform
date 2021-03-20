
/*
# creating VPC
module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "2.63.0" 

  name = "test_vpc"
  cidr = "10.0.0.0/16"

  azs             = ["us-east-2a","us-east-2b"]

  private_subnets = ["10.0.51.0/24","10.0.52.0/24"]
  public_subnets  = ["10.0.1.0/24","10.0.2.0/24"]

  enable_nat_gateway     = true
  single_nat_gateway     = false
  one_nat_gateway_per_az = true
}

*/

/* Create S3 Bucket(s) */

# module "s3-bucket-stack" {
#     source = "../2-sub-modules/s3-bucket-stack"
#     envPrefix = local.envPrefixName
#     resourceTags = local.commonTags
   

# }
/* Create ECR */
resource "null_resource" "example1" {
  provisioner "local-exec" {
    command = "echo 'In the main.tf file in main module'"
  }
}

module "ecr-stack" {
    source = "../2-sub-modules/ecr-stack"
    envPrefix = local.envPrefixName
    resourceTags = local.commonTags
    ecsCluster = local.ecsCluster
     tags =  local.commonTags
}  


module "nike-ecs-with-appmesh" {
  source = "../2-sub-modules/ecs-fargate-stack/nike-defib"
  service_domain = local.service_domain
  envPrefixName = local.envPrefixName
  tags =  local.commonTags
  region = var.region
  Environment = var.Environment
  Stack = var.Stack
  ecsCluster = local.ecsCluster
  nike_ecr_img = local.nike_ecr_img
  defib_ecr_img = local.defib_ecr_img
  scheduler_ecr_img = local.scheduler_ecr_img
  nike_svc_port = var.nike_svc_port
  nike_blue_percent = var.nike_blue_percent
  nike_green_percent = var.nike_green_percent
  defib_svc_port = var.defib_svc_port
  defib_min_task = var.defib_min_task
  nike_min_task = var.nike_min_task
  defib_green_min_task = var.defib_green_min_task
  nike_green_min_task = var.nike_green_min_task
  gateway_min_task = var.gateway_min_task
  gateway_green_min_task = var.gateway_green_min_task
  ecr_url = local.ecr_url
  scheduler_svc_port = var.scheduler_svc_port
  scheduler_min_task = var.scheduler_min_task
  scheduler_green_min_task = var.scheduler_green_min_task
  ssm_splunk_url = var.ssm_splunk_url
  ssm_splunk_token = var.ssm_splunk_token
}

/*
module "nike-ecs-notification" {
  source = "../2-sub-modules/ecs-fargate-notification/notification"
  envPrefixName = local.envPrefixName
  tags =  local.commonTags
  region = var.region
  Environment = var.Environment
  Stack = var.Stack
  ecsCluster = local.ecsCluster
  ecr_url = local.ecr_url
  notification_ecr_img = local.notification_ecr_img
  ssm_splunk_url = var.ssm_splunk_url
  ssm_splunk_token = var.ssm_splunk_token
}

*/