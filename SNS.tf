module "sns_topic_video_load" {
  source  = "terraform-aws-modules/sns/aws"

  name  = var.topicVideoLoadName

  # SQS queue must be FIFO as well
  fifo_topic                  = true
  content_based_deduplication = true

  topic_policy_statements = {
    pub = {
      actions = ["SNS:Publish"]
      principals = [{
        type        = "AWS"
        identifiers = ["arn:aws:iam::${var.arnNumber}:root"]
      }]  
    },

    sub = {
      actions = [
        "SNS:Subscribe"
      ]

      principals = [{
        type        = "AWS"
        identifiers = ["arn:aws:iam::${var.arnNumber}:root"]
      }]

    }
  }

  subscriptions = {
    sqs = {
      protocol = "sqs"
      endpoint = "arn:aws:sqs:${var.region}:${var.arnNumber}:${var.queueVideoLoadName}"
    }
  }

  tags = {
    Environment = "prd"
    Terraform   = "true"
  }
}




module "sns_topic_video_status" {
  source  = "terraform-aws-modules/sns/aws"

  name  = var.topicVideoStatusName

  # SQS queue must be FIFO as well
  fifo_topic                  = true
  content_based_deduplication = true

  topic_policy_statements = {
    pub = {
      actions = ["SNS:Publish"]
      principals = [{
        type        = "AWS"
        identifiers = ["arn:aws:iam::${var.arnNumber}:root"]
      }]  
    },

    sub = {
      actions = [
        "SNS:Subscribe"
      ]

      principals = [{
        type        = "AWS"
        identifiers = ["arn:aws:iam::${var.arnNumber}:root"]
      }]

    }
  }

  subscriptions = {
    sqs = {
      protocol = "sqs"
      endpoint = "arn:aws:sqs:${var.region}:${var.arnNumber}:${var.queueVideoStatusName}"
    }
  }

  tags = {
    Environment = "prd"
    Terraform   = "true"
  }
}