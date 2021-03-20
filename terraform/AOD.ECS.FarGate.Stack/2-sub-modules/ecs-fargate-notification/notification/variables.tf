
// Application Specific Variables
variable "service_domain" {
  type = string
  description = "service domain for app mesh"
  default = "demo.local"

}


// tags
variable "tags" {
  type        = map(string)
  description = "tags to add to all resources created with this module"
  default     = {
    Terraform = "true"
    Module    = "ecs-fargate"  
  }
}

variable "region" {
    type = string
    description = "aws region for ecs deployment"
    
}

variable "ecr_url" {
  type = string
}



variable "notification_ecr_img" {
  type = string
  
}


variable "Environment" {
  type = string
  
}

variable "Stack" {
  type = string
  
}

variable "ecsCluster" {
  type = string
  
}

variable "ssm_splunk_url" {
    type    = string
}

variable "ssm_splunk_token" {
    type    = string
}

# locals {
#     AWSEnvironment = "${var.Stack}-${var.Environment}-"
# }

variable "envPrefixName" {
  type = string
}