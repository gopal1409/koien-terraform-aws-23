###target group
resource "aws_alb_target_group" "front" {
  name = "application-front"
  port = 80
  protocol = "HTTP"
  vpc_id = aws_vpc.this.id 
  #lifecycle { create_before_destroy=true }

  health_check {
    enabled = true 
    path = "/"
    port = "traffic-port"
    healthy_threshold = 6
    unhealthy_threshold = 2
    timeout = 2
    interval = 5
    matcher = "200"  # has to be HTTP 200 or fails
  }
}

resource "aws_lb_target_group_attachment" "attach-app1" {
  count = length(aws_instance.app-server)
  target_group_arn = aws_alb_target_group.front.arn 
  target_id = element(aws_instance.app-server.*.id,count.index)
  port = 80 
}

resource "aws_lb_listener" "front_end" {
  load_balancer_arn = aws_lb.front.arn
  port = "80"
  protocol = "HTTP"
  default_action {
    type = "forward"
    target_group_arn = aws_alb_target_group.front.arn 
  }
}

resource "aws_lb" "front" {
  name = "front"
  internal = false 
  load_balancer_type = "application"
  security_groups = [aws_security_group.allow_http.id]
  subnets = [for subnet in aws_subnet.private : subnet.id]
  enable_deletion_protection = false 
}