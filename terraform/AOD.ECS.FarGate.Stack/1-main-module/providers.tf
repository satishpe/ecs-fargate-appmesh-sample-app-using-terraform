terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
    }
  }


  backend "s3" {
    bucket         = "awsxmpl-aod-cicd-poc"
    key            = "AOD.ECS.FarGate.Stack/terraform.tfstate"
    region         = "us-east-2"
    dynamodb_table = "awsxmpl-aod-cicd-terraform-locks"
}



}

provider "aws" {
  region = "us-east-2"
  profile = "default"
}
