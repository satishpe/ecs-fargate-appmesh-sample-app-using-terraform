data "aws_vpc" "foundation" {
  id = "vpc-027fc89527123ced7"
}



module "notification" {
  source            = "./../"
  region            = var.region
  app_name          = "notification"
  app_port          = "80"
  env               = var.Environment
  vpc               = "vpc-027fc89527123ced7"  //data.aws_vpc.foundation.vpc_id
  //app_image         = "226767807331.dkr.ecr.us-west-2.amazonaws.com/colorteller:latest"
  app_image         = "${var.ecr_url}/${var.notification_ecr_img}:${var.Environment}"
  prefix            = var.Stack
  tags              = var.tags
  ecsCluster        = var.ecsCluster
  # min_app_count     = var.notification_min_task
  min_app_count     = 1
  ssm_splunk_url = var.ssm_splunk_url
  ssm_splunk_token = var.ssm_splunk_token
}