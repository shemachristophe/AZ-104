terraform {
  required_version = "~> 1.0"
  backend "s3" {
    bucket = "shema-remote2-state-bucket"
    key    = "shema-remote2-state-bucket"
    region = "us-west-1"
    encrypt = true
  }
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}

provider "aws" {
  region = "us-west-1"

}

resource "aws_s3_bucket" "s3Bucket" {
  bucket = "shema-cool-tf-bucket"
  tags = {
    Name = "Shema Bucket"
    Environment = "dev"
  }
  policy = <<EOF
  {
    "Id": "MakePublic",
    "Version": "2012-10-17",
    "Statement": [
      {
        "Action": [
          "s3:GetObject"
        ],
        "Effect": "Allow",
        "Resource": "arn:aws:s3:::shema-cool-tf-bucket/*",
        "Principal": "*"
      }
    ]
  }
  EOF
}

resource "aws_s3_bucket_acl" "shema-cool-tf-bucket-acl" {
  bucket = aws_s3_bucket.shema-cool-tf-bucket.id
  acl    = "private"
}
