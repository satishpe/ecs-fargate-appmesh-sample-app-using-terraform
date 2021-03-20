variable "envPrefix" {
    description = "provide prefix for resources"
}

variable "resourceTags" {
    description = "add resource tags upon creation"
}

variable "ecsCluster" {
  type = string
  
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
