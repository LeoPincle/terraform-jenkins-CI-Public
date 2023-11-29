output "vpc_id" {
  value = aws_vpc.project_vpc.id
}

output "publicA_id" {
  value = aws_subnet.project_publicA.id
}

output "publicB_id" {
  value = aws_subnet.project_publicB.id
}

output "privateA_id" {
  value = aws_subnet.project_privateA.id
}

output "privateB_id" {
  value = aws_subnet.project_privateB.id
}