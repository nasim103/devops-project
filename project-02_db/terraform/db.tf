resource "aws_db_instance" "project2-db" {
    identifier = "mydatabase"
    engine = "mysql"
    instance_class = "db.t2.micro"
    allocated_storage = "20"
    username = "admin"
    password = "admin123"
    db_subnet_group_name = aws_db_subnet_group.db-subnet.name
    vpc_security_group_ids = [aws_security_group.project2-dbsg.id]
    skip_final_snapshot = true 
    tags = {
      Name = "mysql-db"
    }
  
}
output "aws-db-dns" {
    value = aws_db_instance.project2-db.endpoint
  
}