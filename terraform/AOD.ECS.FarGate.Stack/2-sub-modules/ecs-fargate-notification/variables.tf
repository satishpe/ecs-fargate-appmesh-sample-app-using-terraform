
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

// app variables
variable "app_name" {
  type        = string
  description = "application name"
}

variable "app_port" {
  type        = string
  description = "app port to expose"
}

variable "env" {
  type        = string
  description = "app deployment environment"
}

# variable "logconfig" {
#   type = string
#   description = "logConfiguration"
# }

# variable "logconfig_splunk" {
#   type = string
#   description = "logConfiguration for splunk"
# }


variable "app_image" {
  type = string
  description = "docker image or by default creates ECS repo"
  default = "none"
}

variable "vpc" {
  description = "vpc id to create resources"
}


variable "prefix" {
  type        = string
  description = "project prefix added to all resources created"
  default = "awsxmpl-dev"
}


variable "min_app_count" {
  type        = number
  description = "minimum number of app containers running"
  default     = 1
}


// fargate cluster Variables
variable "fargate_cpu" {
  type        = string
  description = "fargate instance CPU units to provision (1 vCPU = 1024 CPU units)"
  default     = "1024"
}

variable "fargate_memory" {
  type        = string
  description = "fargate instance memory to provision (in MiB)"
  default     = "2048"
}
