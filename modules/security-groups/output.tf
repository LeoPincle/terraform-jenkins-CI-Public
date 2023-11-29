output "lb_SG_B_id" {
  value = aws_security_group.lb_SG_B.id
}

output "instance_sg_id" {
  value = aws_security_group.instance_sg.id
}