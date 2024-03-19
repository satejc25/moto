resource "aws_s3_bucket" "motogp-s3" {
    bucket = var.s3_bucket
    tags = {
  
      Environment = var.Environment
    }
    object_lock_enabled = true
}
