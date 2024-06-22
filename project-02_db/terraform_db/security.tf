resource "aws_security_group" "project2-dbsg" {
    vpc_id = aws_vpc.project-db.id
    ingress {
        from_port = 3306
        to_port = 3306
        protocol = "tcp"
        security_groups = [ aws_security_group.Project2-ec2.id ]
    } 
    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = [ "0.0.0.0/0" ]
    }
    tags = {
      Name = "db-securitygp"
    }
  
}

## Security group for EC2
resource "aws_security_group" "Project2-ec2" {
    vpc_id = aws_vpc.project-db.id
    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
  
}

## DB subnet group

resource "aws_db_subnet_group" "db-subnet" {
    name = "aws-db-subnet"
    subnet_ids = [ aws_subnet.private-subnet1.id, aws_subnet.private-subnet2.id ]
    tags = {
      Name = "db-subnet"
    }
  
}
