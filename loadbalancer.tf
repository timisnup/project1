#Application Loadbalancer
resource "aws_lb" "application-lb" {
  name               = "app-lb"
  internal           = false
  load_balancer_type = "application"
  ip_address_type    = "ipv4"
  security_groups    = [aws_security_group.sec-group.id]
  subnets            = [aws_subnet.pub-sub-1.id, aws_subnet.pub-sub-2.id]

  tags = {
    Environment = "app-lb"
  }
}

#ALB target group
resource "aws_lb_target_group" "alb_targetgroup" {
  health_check {
    protocol            = "HTTP"
    path                = "/"
    healthy_threshold   = "5"
    unhealthy_threshold = "2"
    timeout             = "5"
    interval            = "30"
  }

  name        = "target-group"
  target_type = "instance"
  port        = 80
  protocol    = "HTTP"
  vpc_id      = aws_vpc.project1.id
}


#Listeners
resource "aws_lb_listener" "alb_listener" {
  load_balancer_arn = aws_lb.application-lb.arn
  port              = "80"
  protocol          = "HTTP"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.alb_targetgroup.arn
  }
}