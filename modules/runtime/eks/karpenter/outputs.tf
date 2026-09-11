output "karpenter_controller_role_arn" {
  description = "ARN of the Karpenter controller IAM role."
  value       = aws_iam_role.karpenter_controller.arn
}

output "karpenter_controller_role_name" {
  description = "Name of the Karpenter controller IAM role."
  value       = aws_iam_role.karpenter_controller.name
}

output "interruption_queue_name" {
  description = "Karpenter interruption SQS queue name."
  value       = aws_sqs_queue.karpenter_interruption.name
}

output "interruption_queue_url" {
  description = "Karpenter interruption SQS queue URL."
  value       = aws_sqs_queue.karpenter_interruption.url
}

output "interruption_queue_arn" {
  description = "Karpenter interruption SQS queue ARN."
  value       = aws_sqs_queue.karpenter_interruption.arn
}
