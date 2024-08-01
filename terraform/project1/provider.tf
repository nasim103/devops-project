provider "aws" {
    region = "us-east-1"
    access_key = "var.access-key"
    secret_key = "var.secret-key"
  
}

terraform {
  backend "s3" {
    bucket = "terraform-projedct-r1"
    region = "us-east-1"
    key = "terraform.tfstate"
    dynamodb_table = "terraform-table"
    
  }
}