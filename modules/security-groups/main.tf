resource "aws_security_group" "lb_SG_B" {
  name   = "lb_SG_B"
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 0
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 3000
    to_port     = 3000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  vpc_id = var.vpc_id

}


resource "aws_security_group" "instance_sg" {
  name   = "instance_sg"
  ingress {
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    security_groups = [aws_security_group.lb_SG_B.id]
    cidr_blocks       = ["0.0.0.0/0"]
  }

  ingress {
    from_port       = 0
    to_port         = 80
    protocol        = "tcp"
    security_groups = [aws_security_group.lb_SG_B.id]
    cidr_blocks       = ["0.0.0.0/0"]
  }

  ingress {
    from_port       = 3000
    to_port         = 3000
    protocol        = "tcp"
    security_groups = [aws_security_group.lb_SG_B.id]
    cidr_blocks       = ["0.0.0.0/0"]
  }

  ingress {
    from_port       = 22
    to_port         = 22
    protocol        = "tcp"
    security_groups = [aws_security_group.lb_SG_B.id]
    cidr_blocks       = ["0.0.0.0/0"]
  }

  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    security_groups = [aws_security_group.lb_SG_B.id]
    cidr_blocks       = ["0.0.0.0/0"]

  }
  vpc_id = var.vpc_id

}

