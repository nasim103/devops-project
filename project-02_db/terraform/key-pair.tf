resource "aws_key_pair" "project2-ec2" {
    key_name = "mykey"
    public_key = file("mykey.pub")
  
}