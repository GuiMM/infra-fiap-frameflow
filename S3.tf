
#S3 Bucket original
resource "aws_s3_bucket" "original" {
  bucket = var.originalVideoS3Name

  tags = {
    Name        = "FrameFlow bucket"
    Environment = "PRD"
  }
}


#S3 Bucket Frames
resource "aws_s3_bucket" "frames" {
  bucket = var.framesVideoS3Name

  tags = {
    Name        = "FrameFlow bucket"
    Environment = "PRD"
  }
}
