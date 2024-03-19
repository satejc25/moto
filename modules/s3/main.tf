resource "aws_s3_bucket" "motogp-buck" {
    bucket = var.bucket
    tags = {
      Name = "${var.project}-bucket"
      Environment = var.Environment
    }
    object_lock_enabled = true
  
}