output "frontend_lb" {
  value = aws_lb.frontend_lb
}

output "frontend_lb_id" {
  value = aws_lb.frontend_lb.id
}

output "frontend_lb_dns_name" {
  value = aws_lb.frontend_lb.dns_name
}

output "frontend_TG" {
  value = aws_lb_target_group.frontend_TG
}

output "frontend_TG_id" {
  value = aws_lb_target_group.frontend_TG.id
}

output "frontend_TG_arn" {
  value = aws_lb_target_group.frontend_TG.arn
}