resource "aws_instance" "Project2-ec2" {
    instance_type = "t2.micro"
    ami = "ami-08a0d1e16fc3f61ea"
    vpc_security_group_ids = [ aws_security_group.Project2-ec2.id ]
    subnet_id = aws_subnet.public_subnet1.id
    key_name = aws_key_pair.project2-ec2.key_name
    
  
}
output "publicip" {
    value = aws_instance.Project2-ec2.public_ip
  
}