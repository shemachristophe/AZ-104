resource "aws_s3_bucket" "s3Bucket" {
  bucket = "shema-cool-tf-bucket"
  tags = {
    Name = "Shema Bucket"
    Environment = "CI"
  }
}

resource "aws_s3_bucket_acl" "shema-cool-tf-bucket-acl" {
  bucket = aws_s3_bucket.s3Bucket.id
  acl    = "private"
}
