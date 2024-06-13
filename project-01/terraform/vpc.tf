resource "aws_vpc" "project1" {
  cidr_block = "10.0.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support = true
  tags = {
    Name = "project1-vpc"
  }

}

resource "aws_subnet" "public-subnet1" {
  vpc_id = aws_vpc.project1.id
  cidr_block = "10.0.1.0/24"
  availability_zone = "us-east-1a"
  map_public_ip_on_launch = true
  tags = {
    Name = "public-subnet1"
  }
}

resource "aws_subnet" "public-subnet2" {
  vpc_id = aws_vpc.project1.id
  availability_zone = "us-east-1b"
  cidr_block = "10.0.2.0/24"
  map_public_ip_on_launch = true
  tags = {
    Name = "public-subnet2"
  }
}

resource "aws_subnet" "private-subnet1" {
  vpc_id = aws_vpc.project1.id
  availability_zone = "us-east-1a"
  cidr_block = "10.0.3.0/24"
  map_public_ip_on_launch = false
  tags = {
    Name = "private-subnet1"
  }
}

resource "aws_subnet" "private-subnet2" {
    vpc_id = aws_vpc.project1.id
    availability_zone = "us-east-1b"
    map_public_ip_on_launch = false
    cidr_block = "10.0.4.0/24"
    tags = {
      Name =  "private-subnet2"
    }
}

resource "aws_internet_gateway" "project1-igw" {
    vpc_id = aws_vpc.project1.id
    tags = {
      Name = "project1-igw"
    }
  
}

resource "aws_route_table" "project1-route" {
    vpc_id = aws_vpc.project1.id
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.project1-igw.id
    }
    tags = {
      Name = "project1-route-table"
    }
  
}

resource "aws_route_table_association"  "project1" {
    route_table_id = aws_route_table.project1-route.id
    subnet_id = aws_subnet.public-subnet1.id
}

resource "aws_route_table_association" "project1-rouet2" {
    subnet_id = aws_subnet.public-subnet2.id
    route_table_id = aws_route_table.project1-route.id
  
}