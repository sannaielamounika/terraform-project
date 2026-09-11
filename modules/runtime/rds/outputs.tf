output "db_instance_id" {
  description = "RDS DB instance identifier."
  value       = aws_db_instance.this.id
}

output "db_instance_arn" {
  description = "RDS DB instance ARN."
  value       = aws_db_instance.this.arn
}

output "db_endpoint" {
  description = "RDS database endpoint address."
  value       = aws_db_instance.this.address
}

output "endpoint" {
  description = "Alias for db_endpoint"
  value       = aws_db_instance.this.address
}

output "db_port" {
  description = "RDS database port."
  value       = aws_db_instance.this.port
}

output "port" {
  description = "Alias for db_port"
  value       = aws_db_instance.this.port
}

output "db_engine" {
  description = "RDS database engine."
  value       = aws_db_instance.this.engine
}

output "db_subnet_group_name" {
  description = "RDS DB subnet group name."
  value       = aws_db_subnet_group.this.name
}

output "master_user_secret_arn" {
  description = "Secrets Manager ARN created by RDS when RDS manages the master password."
  value       = try(aws_db_instance.this.master_user_secret[0].secret_arn, null)
}
