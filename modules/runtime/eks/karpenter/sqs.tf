resource "aws_sqs_queue" "karpenter_interruption" {
  name                       = "${local.name_prefix}-interruption"
  message_retention_seconds  = 300
  visibility_timeout_seconds = 30
  sqs_managed_sse_enabled    = true
  tags                       = local.common_tags
}

data "aws_iam_policy_document" "karpenter_sqs" {
  statement {
    sid    = "AllowEventBridge"
    effect = "Allow"
    principals {
      type        = "Service"
      identifiers = ["events.amazonaws.com"]
    }
    actions   = ["sqs:SendMessage"]
    resources = [aws_sqs_queue.karpenter_interruption.arn]
  }
}

resource "aws_sqs_queue_policy" "karpenter_interruption" {
  queue_url = aws_sqs_queue.karpenter_interruption.id
  policy    = data.aws_iam_policy_document.karpenter_sqs.json
}
