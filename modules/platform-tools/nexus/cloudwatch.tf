resource "aws_cloudwatch_metric_alarm" "cpu_high" {
  count = var.monitoring.enabled && var.monitoring.cpu.enabled ? 1 : 0

  alarm_name          = "${local.name_prefix}-high-cpu"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = var.monitoring.cpu.evaluation_periods
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = var.monitoring.cpu.period
  statistic           = var.monitoring.cpu.statistic
  threshold           = var.monitoring.cpu.threshold

  alarm_description = "Monitors ${local.tool_name} CPU utilization"

  dimensions = {
    InstanceId = aws_instance.this.id
  }

  tags = local.common_tags
}

resource "aws_cloudwatch_metric_alarm" "status_check_failed" {
  count = var.monitoring.enabled && var.monitoring.status_check.enabled ? 1 : 0

  alarm_name          = "${local.name_prefix}-status-check-failed"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = var.monitoring.status_check.evaluation_periods
  metric_name         = "StatusCheckFailed"
  namespace           = "AWS/EC2"
  period              = var.monitoring.status_check.period
  statistic           = var.monitoring.status_check.statistic
  threshold           = var.monitoring.status_check.threshold

  alarm_description = "Monitors ${local.tool_name} instance status check failure"

  dimensions = {
    InstanceId = aws_instance.this.id
  }

  tags = local.common_tags
}
