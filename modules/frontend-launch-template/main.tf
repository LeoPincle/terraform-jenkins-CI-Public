resource "aws_launch_template" "frontend_ltp" {
  name_prefix = "frontend_ltp"
  image_id = "ami-0fc5d935ebf8bc3bc" 
  instance_type = "t2.micro"
  network_interfaces {
    security_groups = [ "${var.instance_sg}" ]

    associate_public_ip_address = true
  }
  
  user_data = "${base64encode(file("${path.module}/frontend.sh"))}"
  lifecycle {
      create_before_destroy = true
    }
}
