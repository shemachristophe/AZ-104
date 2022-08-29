terraform {
  required_version = "~> 1.0"
  backend "s3" {
    bucket = "shema-remote2-state-bucket"
    region = "us-west-1"
    key = "shema-remote2-state-bucket"
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
  region = var.region

}
