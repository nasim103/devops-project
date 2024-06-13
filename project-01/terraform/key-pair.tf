resource "aws_key_pair" "project1-key" {
    key_name = id_rsa
    public_key = file("~/.ssh/id_rsa.pub")
  
}