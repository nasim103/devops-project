locals {
  common_tag = {
    Env = "Dev"
    CostCenter = "423424"
    ManagedBy = "Terraform"
  }
}

resource "aws_vpc" "main" {
    cidr_block = "10.0.0.0/16"

    tags = local.common_tag
  
}

resource "aws_subnet" "public-subnet" {
    vpc_id = aws_vpc.main.id
    cidr_block = "10.0.1.0/24"

    tags = merge({local.common_tag}, {
        Team = "Dev"
    }
    )
  
}
