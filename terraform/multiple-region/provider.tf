provider "aws" {
  region = "us-east-1"
}

provider "aws" {
  region = "eu-west-1"
  alias = "eu-west"
}
  
terraform {
    required_version = "~> 1.0"

    required_providers {
     aws = {
       source = "hashicorp/aws"
       version = "~> 5.0"       
     }    
     random = {
        source = "hashicorp/random"
        version = ">= 3.0"
     }
  }
  backend "s3" {
    bucket = "terraform-projedct-r1"
    region = "us-east-1"
    key = "terraform.tfstate"
    dynamodb_table = "terraform-table"
    
  }
}