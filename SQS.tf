resource "aws_sqs_queue" "video_load_queue" {
  depends_on = [ module.sns_topic_video_load ]
  name                        = var.queueVideoLoadName
  fifo_queue                  = true
  content_based_deduplication = false
}


resource "aws_sqs_queue_policy" "sns_to_sqs_video_load" {
  depends_on = [ module.sns_topic_video_load ]
  queue_url = "https://sqs.${var.region}.amazonaws.com/${var.arnNumber}/${var.queueVideoLoadName}"

  policy = jsonencode({
    Version = "2012-10-17"
    Id      = "__default_policy_ID"
    Statement = [
      {
        Sid       = "__owner_statement"
        Effect    = "Allow"
        Principal = {
          AWS = "arn:aws:iam::090111931170:root"
        }
        Action = "SQS:*"
        Resource = "arn:aws:sqs:${var.region}:${var.arnNumber}:${aws_sqs_queue.video_load_queue.name}"
      },
      {
        Sid       = "topic-subscription-arn:aws:sns:${var.region}:${var.arnNumber}:${var.topicVideoLoadName}"
        Effect    = "Allow"
        Principal = {
          AWS = "*"
        }
        Action = "SQS:SendMessage"
        Resource = "arn:aws:sqs:${var.region}:${var.arnNumber}:${aws_sqs_queue.video_load_queue.name}"
        Condition = {
          ArnLike = {
            "aws:SourceArn" = "arn:aws:sns:${var.region}:${var.arnNumber}:${var.topicVideoLoadName}"
          }
        }
      }
    ]
  })
}



resource "aws_sqs_queue" "video_status_queue" {
  depends_on = [ module.sns_topic_video_status ]
  name                        = var.queueVideoStatusName
  fifo_queue                  = true
  content_based_deduplication = false
}


resource "aws_sqs_queue_policy" "sns_to_sqs_video_status" {
  depends_on = [ module.sns_topic_video_status ]
  queue_url = "https://sqs.${var.region}.amazonaws.com/${var.arnNumber}/${var.queueVideoStatusName}"

  policy = jsonencode({
    Version = "2012-10-17"
    Id      = "__default_policy_ID"
    Statement = [
      {
        Sid       = "__owner_statement"
        Effect    = "Allow"
        Principal = {
          AWS = "arn:aws:iam::090111931170:root"
        }
        Action = "SQS:*"
        Resource = "arn:aws:sqs:${var.region}:${var.arnNumber}:${aws_sqs_queue.video_status_queue.name}"
      },
      {
        Sid       = "topic-subscription-arn:aws:sns:${var.region}:${var.arnNumber}:${var.topicVideoStatusName}"
        Effect    = "Allow"
        Principal = {
          AWS = "*"
        }
        Action = "SQS:SendMessage"
        Resource = "arn:aws:sqs:${var.region}:${var.arnNumber}:${aws_sqs_queue.video_status_queue.name}"
        Condition = {
          ArnLike = {
            "aws:SourceArn" = "arn:aws:sns:${var.region}:${var.arnNumber}:${var.topicVideoStatusName}"
          }
        }
      }
    ]
  })
}

