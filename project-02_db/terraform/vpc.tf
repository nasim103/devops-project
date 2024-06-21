resource "aws_vpc" "project-db" {
  cidr_block = "10.0.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support = true
  tags = {
    Name = "Project-db"
  }
  
}

resource "aws_subnet" "public_subnet1" {
  vpc_id = aws_vpc.project-db.id
  cidr_block = "10.0.1.0/24"
  map_public_ip_on_launch = true
  availability_zone = "us-east-1a"
  tags = {
    Name = "public-subnet1"
  }
}

resource "aws_subnet"  "public-subnet2" {
    vpc_id = aws_vpc.project-db.id
    cidr_block = "10.0.2.0/24"
    map_public_ip_on_launch = true
    availability_zone = "us-east-1b"
    tags = {
      Name = "public-subnet2"
    }
  
}

resource "aws_subnet" "private-subnet1" {
  vpc_id = aws_vpc.project-db.id
  cidr_block = "10.0.3.0/24"
  availability_zone = "us-east-1a"
  map_public_ip_on_launch = false
  tags = {
    Name = "private-subnet1"
  }
}

resource "aws_subnet" "private-subnet2" {
    vpc_id = aws_vpc.project-db.id
    availability_zone = "us-east-1b"
    cidr_block = "10.0.4.0/24"
    map_public_ip_on_launch = false
    tags = {
      Name = "private-subnet2"
    }
}

resource "aws_internet_gateway" "Project2" {
    vpc_id = aws_vpc.project-db.id
    tags = {
      Name = "project2-igw"
    } 
}

resource "aws_route_table" "Project2-route" {
    vpc_id = aws_vpc.project-db.id
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.Project2.id
    }
    tags = {
      Name = "route_table"
    }
}

resource "aws_route_table_association" "Project2-rt1" {
    subnet_id = aws_subnet.public_subnet1.id
    route_table_id = aws_route_table.Project2-route.id
  
}
resource "aws_route_table_association" "Project2-rt2" {
    subnet_id = aws_subnet.public-subnet2.id
    route_table_id = aws_route_table.Project2-route.id 
}

