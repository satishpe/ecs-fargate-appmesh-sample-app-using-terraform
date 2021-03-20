/*
Module: ECS-Fargate-APPMESH
Version: 1.0.0

This file defines all the variables for this module.
Variables are divided into two sections:
  - Required variables
  - Optional variables
*/

//  -------------Module Variables(Required)---------------
// project variables
variable "region" {
  type        = string
  description = "region where to create resources"
}

variable "env" {
  type        = string
  description = "app deployment environment"
}

// app variables
variable "app_name" {
  type        = string
  description = "application name"
}

variable "app_port" {
  type        = string
  description = "app port to expose"
}

variable "appmesh" {
  description = "appmesh resource to create virtual node and service"
}

variable "cloudmap_service" {
  description = "register service in cloudpmap"
}

variable "cw_dashboard" {
  type        = string
  description = "set to true to add cloudwatch dashboard"
  default     = "none"
}

variable "service_domain" {
  type = string
  description = "service domain for app mesh"
  default = "demo.local"

}
// vpc variables
variable "vpc" {
  description = "vpc id to create resources"
}


// -------------General(optional)---------------
variable "prefix" {
  type        = string
  description = "project prefix added to all resources created"
  default = "awsxmpl-dev"
}

// app variables


# variable "nike_green_min_task" {
#   type = string
# }

# variable "defib_green_min_task" {
#   type = string
# }


# variable "nike_min_task" {
#   type = string
# }

# variable "defib_min_task" {
#   type = string
# }



variable "app_image" {
  type = string
  description = "docker image or by default creates ECS repo"
  default = "none"
}

variable "min_app_count" {
  type        = number
  description = "minimum number of app containers running"
  default     = 1
}

variable "extra_ports" {
  type        = list(string)
  description = "additional ports to expose. useful case: rabbitmq"
  default     = []
}

variable "secrets" {
  type = list(string)
  description = "allow fargate task accesss to secret manager secrets"
  default = []
}

// appmesh variables
variable "aws_appmesh_virtual_node" {
  type = string
  description = "set appmesh virtual node"
  default = "none"
}

variable "virtual_gateway" {
  type = string
  description = "set appmesh virtual gateway"
  default = "none"
}

variable "envoy_proxy_image" {
  type        = string
  description = "app mesh image for all regions except me-south-1 and ap-east-1"
  default     = "840364872350.dkr.ecr.us-east-1.amazonaws.com/aws-appmesh-envoy:v1.15.1.0-prod"
}

// load balancer variables
variable "certificate_arn" {
  type        = string
  description = "set to true to add ssl to alb"
  default     = "none"
}

variable "nlb_stickiness" {
  type = bool
  description = "enable stickiness for network load balancer"
  default = false
}

// add xray to task definition
variable "xray" {
  type = bool
  description = "add xray daemon as sidecar"
  default = true
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

// -------------Fargate variables(optional)------------------

variable "ecsCluster" {
  type = string
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


variable "ssm_splunk_url" {
    type    = string
}

variable "ssm_splunk_token" {
    type    = string
}