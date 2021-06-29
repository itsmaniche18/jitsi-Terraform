resource "aws_launch_configuration" "jvb" {
  name            = "${var.AUTOSCALING_NAME}-lc"
  image_id        = var.IMAGE_ID
  instance_type   = var.INSTANCE_TYPE
  security_groups = [aws_security_group.jvb.id]
  key_name        = "jisti_cluster_key"
  user_data       = file("${path.module}/shell/config.sh")
}

resource "aws_autoscaling_group" "jvb" {
  name                      = var.AUTOSCALING_NAME
  min_size                  = var.MIN_SIZE
  max_size                  = var.MAX_SIZE
  desired_capacity          = var.DESIRED_CAPACITY
  health_check_type         = "EC2"
  launch_configuration      = aws_launch_configuration.jvb.name
  force_delete              = true
  capacity_rebalance        = true
  vpc_zone_identifier       = var.SUBNETS
  enabled_metrics           = ["GroupTotalInstances", "GroupMinSize", "GroupMaxSize", "GroupInServiceInstances"]
  wait_for_capacity_timeout = "10m"
  protect_from_scale_in     = false
}

resource "aws_autoscaling_policy" "jvb-scaleup" {
  name                   = "${var.AUTOSCALING_NAME}-policy-up"
  scaling_adjustment     = var.UP_SCALING_ADJUSTMENT
  adjustment_type        = var.ADJUSTMENT_TYPE
  cooldown               = var.COOLDOWN_TIME
  autoscaling_group_name = aws_autoscaling_group.jvb.name
}

resource "aws_autoscaling_policy" "jvb-scalein" {
  name                   = "${var.AUTOSCALING_NAME}-policy-in"
  scaling_adjustment     = -1
  adjustment_type        = var.ADJUSTMENT_TYPE
  cooldown               = var.COOLDOWN_TIME
  autoscaling_group_name = aws_autoscaling_group.jvb.name

}

resource "aws_cloudwatch_metric_alarm" "scaleup" {
  alarm_name          = "${var.AUTOSCALING_NAME}-asg-up"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "1"
  period              = "60"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  statistic           = "Average"
  threshold           = var.HIGH_CPU_THRESHOLD
  alarm_description   = "This is the metric to monitor the cpu usages of instances."
  alarm_actions       = ["${aws_autoscaling_policy.jvb-scaleup.arn}"]
  dimensions = {
    AutoScalingGroupName = aws_autoscaling_group.jvb.name
  }
}

resource "aws_cloudwatch_metric_alarm" "scalein" {
  alarm_name          = "${var.AUTOSCALING_NAME}-asg-in"
  comparison_operator = "LessThanOrEqualToThreshold"
  evaluation_periods  = 1
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = "60"
  statistic           = "Average"
  threshold           = var.LOW_CPU_THRESHOLD
  alarm_description   = "This is the metric to monitor the cpu usages of instances."
  alarm_actions       = ["${aws_autoscaling_policy.jvb-scalein.arn}"]
  dimensions = {
    AutoScalingGroupName = aws_autoscaling_group.jvb.name
  }
}

resource "aws_security_group" "jvb" {
  name   = "${var.AUTOSCALING_NAME}-jvb"
  vpc_id = var.vpcid
  ingress {
    description = "allow all"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    description = "allow all"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
