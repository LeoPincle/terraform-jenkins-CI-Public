resource "aws_autoscaling_group" "asg_frontend" {
  name     = "asg_frontend"
  min_size = 1
  max_size = 2

  health_check_type = "EC2"

  vpc_zone_identifier = [
    var.publicA_id,
    var.publicB_id
  ]

  target_group_arns = [var.frontend_tg_arn]

  mixed_instances_policy {
    launch_template {
      launch_template_specification {
        launch_template_id = var.frontend_launch_id
      }
      
    }
  }
}