resource "aws_sqs_queue" "video_load_queue" {
  name                        = var.queueVideoLoadName
  fifo_queue                  = true
  content_based_deduplication = false
}


resource "aws_sqs_queue_policy" "sns_to_sqs_video_load" {
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

#Assinaturas para o SNS de status(MS alteracao status)

resource "aws_sqs_queue" "video_status_queue_alter_status" {
  name                        = var.queueVideoStatusNameAlterStatus
  fifo_queue                  = true
  content_based_deduplication = false
}


resource "aws_sqs_queue_policy" "sns_to_sqs_video_alter_status" {
  queue_url = "https://sqs.${var.region}.amazonaws.com/${var.arnNumber}/${var.queueVideoStatusNameAlterStatus}"

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
        Resource = "arn:aws:sqs:${var.region}:${var.arnNumber}:${aws_sqs_queue.video_status_queue_alter_status.name}"
      },
      {
        Sid       = "topic-subscription-arn:aws:sns:${var.region}:${var.arnNumber}:${var.topicVideoStatusName}"
        Effect    = "Allow"
        Principal = {
          AWS = "*"
        }
        Action = "SQS:SendMessage"
        Resource = "arn:aws:sqs:${var.region}:${var.arnNumber}:${aws_sqs_queue.video_status_queue_alter_status.name}"
        Condition = {
          ArnLike = {
            "aws:SourceArn" = "arn:aws:sns:${var.region}:${var.arnNumber}:${var.topicVideoStatusName}"
          }
        }
      }
    ]
  })
}



#Segunda assinatura para o SNS de status(MS notification)

resource "aws_sqs_queue" "video_status_queue_notification" {
  name                        = var.queueVideoStatusNameNotification
  fifo_queue                  = true
  content_based_deduplication = false
}


resource "aws_sqs_queue_policy" "sns_to_sqs_video_notification_status" {
  queue_url = "https://sqs.${var.region}.amazonaws.com/${var.arnNumber}/${var.queueVideoStatusNameNotification}"

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
        Resource = "arn:aws:sqs:${var.region}:${var.arnNumber}:${aws_sqs_queue.video_status_queue_notification.name}"
      },
      {
        Sid       = "topic-subscription-arn:aws:sns:${var.region}:${var.arnNumber}:${var.topicVideoStatusName}"
        Effect    = "Allow"
        Principal = {
          AWS = "*"
        }
        Action = "SQS:SendMessage"
        Resource = "arn:aws:sqs:${var.region}:${var.arnNumber}:${aws_sqs_queue.video_status_queue_notification.name}"
        Condition = {
          ArnLike = {
            "aws:SourceArn" = "arn:aws:sns:${var.region}:${var.arnNumber}:${var.topicVideoStatusName}"
          }
        }
      }
    ]
  })
}
