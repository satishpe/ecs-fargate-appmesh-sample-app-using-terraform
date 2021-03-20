
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

variable "nike_ecr_img" {
  type = string
  
}

variable "defib_ecr_img" {
  type = string
}

variable "scheduler_ecr_img" {
  type = string
}

variable "envPrefixName" {
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

variable "nike_svc_port" {
    type = string
}

variable "defib_svc_port" {
    type = string
}

variable "scheduler_svc_port" {
    type = string
}

variable "nike_green_percent" {
    type = string
    default = "0"
}

variable "nike_blue_percent" {
    type = string
    default = "100"
}

variable "defib_green_percent" {
    type = string
    default = "0"
}

variable "scheduler_green_percent" {
    type = string
    default = "0"
}

variable "defib_blue_percent" {
    type = string
    default = "100"
}

variable "scheduler_blue_percent" {
    type = string
    default = "100"
}

variable "nike_green_min_task" {
  type = string
}

variable "defib_green_min_task" {
  type = string
}

variable "scheduler_green_min_task" {
  type = string
}

variable "nike_min_task" {
  type = string
}

variable "defib_min_task" {
  type = string
}

variable "scheduler_min_task" {
  type = string
}

variable "gateway_green_min_task" {
  type  = string
}

variable "gateway_min_task" {
  type  = string
}


variable "ssm_splunk_url" {
    type    = string
}

variable "ssm_splunk_token" {
    type    = string
}


locals {
    AWSEnvironment = "${var.Stack}-${var.Environment}-"
}