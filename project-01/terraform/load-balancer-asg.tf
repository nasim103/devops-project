resource "aws_alb" "project1-alb" {
    name = "project1-alb"
    internal = false
    load_balancer_type = "application"
    security_groups = [ aws_security_group.project1-sg.id ]
    subnets = [ aws_subnet.public-subnet1.id ]
  
}

resource "aws_launch_configuration" "project1-launch" {
    name = "project1-launch"
    image_id = "ami-08a0d1e16fc3f61ea"
    instance_type = "t2.micro"
    security_groups = [ aws_security_group.project1-sg.id ]
    key_name = aws_key_pair.project1-key.key_name
    lifecycle {
      create_before_destroy = true
    }
    user_data = <<-EOF
            #!/bin/bash
            yum update -y
            amazon-linux-extras install docker -y
            service docker start
            usermod -a -G docker ec2-user
            docker run -d -p 80:80 nasim1039/my-nginx:latest
            EOF
  
}

resource "aws_autoscaling_group" "project1-asg" {
    desired_capacity = 2
    max_size = 2
    min_size = 1
    launch_configuration = aws_launch_configuration.project1-launch.name
    vpc_zone_identifier = [aws_subnet.public-subnet1.id]
    tag {
      key = "Name"
      value = "web-server"
      propagate_at_launch = true 
    }
    target_group_arns = [aws_alb_target_group.project1-tg.arn]
    health_check_type = "EC2"
}

resource "aws_alb_target_group" "project1-tg" {
    name = "project1"
    port = 80
    protocol = "HTTP"
    vpc_id = aws_vpc.project1.id
    health_check {
      interval = 30
      path = "/"
      protocol = "HTTP"
      timeout = 5
      healthy_threshold = 5
      unhealthy_threshold = 2
    }
  
}

resource "aws_alb_listener" "project1-lis" {
    load_balancer_arn = aws_alb.project1-alb.arn
    port = 80
    protocol = "HTTP"
    default_action {
      type = "forward"
      target_group_arn = aws_alb_target_group.project1-tg.arn
    }
  
}