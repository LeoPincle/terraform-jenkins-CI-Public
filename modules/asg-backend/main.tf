resource "aws_autoscaling_group" "asg_backend" {
  name     = "asg_backend"
  min_size = 1
  max_size = 2

  health_check_type = "EC2"

  vpc_zone_identifier = [
    var.privateA_id,
    var.privateB_id
  ]

  target_group_arns = [var.backend_TG_arn]

  mixed_instances_policy {
    launch_template {
      launch_template_specification {
        launch_template_id = var.backend_launch_id
      }
      
    }
  }
}