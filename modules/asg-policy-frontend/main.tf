resource "aws_autoscaling_policy" "asg_policy_frontend" {
  name                   = "asg_policy_frontend"
  policy_type            = "TargetTrackingScaling"
  autoscaling_group_name = var.asg_frontend 

  estimated_instance_warmup = 300

  target_tracking_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ASGAverageCPUUtilization"
    }

    target_value = 25.0
  }
}