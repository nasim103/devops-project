resource "aws_key_pair" "project1-key" {
    key_name = project
    public_key = file("~/.ssh/project.pub")
  
}