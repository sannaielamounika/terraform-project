output "instance_id" {
  value       = aws_instance.this.id
  description = "EC2 Instance ID"
}

output "private_ip" {
  value       = aws_instance.this.private_ip
  description = "Private IP address"
}

output "public_ip" {
  value       = var.enable_eip ? aws_eip.this[0].public_ip : aws_instance.this.public_ip
  description = "Public / Elastic IP address"
}

output "security_group_id" {
  value       = aws_security_group.this.id
  description = "Security Group ID"
}

output "ebs_volume_id" {
  value       = aws_ebs_volume.data.id
  description = "Persistent EBS Volume ID"
}

output "db_password_ssm_parameter" {
  value       = aws_ssm_parameter.db_password.name
  description = "SSM Parameter Name storing SonarQube PostgreSQL password"
}

output "db_username" {
  value       = var.db_username
  description = "PostgreSQL database username"
}

output "db_name" {
  value       = var.db_name
  description = "PostgreSQL database name"
}
