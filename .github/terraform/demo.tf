terraform {
  required_version = "~> 1.0"
  backend "s3" {
    bucket = "shema-remote2-state-bucket"
    key = "shema-remote2-state-bucket"
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
}

resource "aws_s3_bucket_acl" "shema-cool-tf-bucket-acl" {
  bucket = aws_s3_bucket.s3Bucket.id
  acl    = "public-read"
}
