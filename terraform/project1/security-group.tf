resource "aws_security_group" "project1-sg" {
    description = "Project1 security group"
    dynamic "ingress" {
        for_each = [ "22", "3306", "1024", "5142" ]
        iterator = "port"
        content {
            from_port = port.value
            to_port = port.value
            protocol = "tcp"
            cidr_blocks = [ "0.0.0.0/0" ]
          
        }
      
    }
    dynamic "egress" {
      for_each = [ "22", "3306", "1024", "5142" ]
      iterator = "port"
      content {
        from_port = port.value
        to_port = port.value
        protocol = "tcp"
        cidr_blocks = [ "0.0.0.0/0" ]
    }
 }
      

}