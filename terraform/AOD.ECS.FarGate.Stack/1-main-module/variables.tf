variable "projectName" {
    description = "service name"
    type = string
    default = "awsxmpl-nike"
}

variable "environmentType" {
    description = "dev/qa/prod"
    type = string
    default = "dev"
}

locals {
    service_domain = "${var.Stack}.${var.Project}.${var.Environment}.local"
}

locals {
    envPrefixName = "${var.Stack}-${var.Project}-${var.Environment}"
 
}

locals {
    ecsCluster = "${var.Stack}-${var.Project}-${var.Environment}-cluster"
}

locals {

   commonTags = {
    Stack	    =	var.Stack
    Environment	=	var.Environment
    Project	    =	var.Project
    Product	    =	var.Product
    Creator	    =	var.Creator
    Owner	    =	var.Owner
    ManagedBy	=	var.ManagedBy

    }

}

locals {
    ecr_url = "${var.aws_account_id}.dkr.ecr.${var.region}.amazonaws.com"
}

locals {
    nike_ecr_img = "${var.Stack}-${var.Project}-${var.Environment}-nike-ecr"
}

locals {
    defib_ecr_img = "${var.Stack}-${var.Project}-${var.Environment}-defib-ecr"
}

locals {
    scheduler_ecr_img = "${var.Stack}-${var.Project}-${var.Environment}-scheduler-ecr"
}


locals {
    notification_ecr_img = "${var.Stack}-${var.Project}-${var.Environment}-notification-ecr"
}

variable "aws_account_id" {
  type  = string
}

variable "region" {
    type = string
    description = "region for the deployment"
}

variable "Stack" {
    description = "Stack"
    type = string
}

variable "Environment" {
    description = ""
    type = string
}

variable "Project" {
    description = ""
    type = string
}

variable "Product" {
    description = ""
    type = string
}

variable "Role" {
    description = ""
    type = string
}

variable "Creator" {
    description = ""
    type = string
}

variable "Owner" {
    description = ""
    type = string
}

variable "Version" {
    description = ""
    type = string
}

variable "Timetolive" {
    description = ""
    type = string
}

variable "Customer" {
    description = ""
    type = string
}

variable "ManagedBy" {
    description = ""
    type = string
}

variable "nike_svc_port" {
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

variable "defib_svc_port" {
    type = string
}


variable "defib_green_percent" {
    type = string
    default = "0"
}

variable "defib_blue_percent" {
    type = string
    default = "100"
}

variable "scheduler_svc_port" {
    type = string
}


variable "scheduler_green_percent" {
    type = string
    default = "0"
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