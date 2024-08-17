terraform {
  required_version = "~> 1.7"

  required_providers {
    aws = {
        source = "hashicorp/aws"
        version = "~> 5.0"
    }
  }
}

provider "aws" {
    region = "eu-west-1"
    access_key = {}
    secret_key = {}
  
}