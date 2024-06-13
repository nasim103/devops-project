resource "aws_key_pair" "project1-key" {
    key_name = mykey
    public_key = file("mykey.pub")
  
}