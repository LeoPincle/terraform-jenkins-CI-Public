resource "aws_lb" "frontend_lb" {
  name               = "frontendlb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [var.lb_SG_B_id]

  subnets = [
    var.publicA_id,
    var.publicB_id
  ]
}

resource "aws_lb_target_group" "frontend_TG" {
  name     = "frontendTG"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id

  health_check {
    enabled             = true
    port                = 80
    protocol            = "HTTP"
    path                = "/"
    matcher             = "200"
    healthy_threshold   = 3
    unhealthy_threshold = 3
  }
}

resource "aws_lb_listener" "frontendListener_A" {
  load_balancer_arn = aws_lb.frontend_lb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.frontend_TG.arn
  }
}
