provider "aws" {
  version = "~>3.0"
  region  = "us-west-1"
}
terraform {
  backend "s3" {
    bucket = "shema-remote-state-bucket"
    key    = "shema-remote-state-bucket"
    region = "us-west-1"
  }
}

resource "aws_s3_bucket" "s3Bucket" {
  bucket = "shema-cool-tf-bucket"
  acl    = "private"

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

  website {
    index_document = "index.html"
  }
}
