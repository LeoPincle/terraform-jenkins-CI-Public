resource "aws_launch_template" "backend_lcf" {
  name_prefix = "backend_lcf"
  image_id = "ami-0fc5d935ebf8bc3bc" 
  instance_type = "t2.micro"
  network_interfaces {
    security_groups = [ "${var.instance_sg}" ]

    associate_public_ip_address = true
  }
  
  user_data = "${base64encode(file("${path.module}/backend.sh"))}"#"${base64encode(file("./backend.sh"))}"
  lifecycle {
      create_before_destroy = true
    }
}
