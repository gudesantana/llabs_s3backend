terraform {
  required_version = ">= 1.2.5"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 4.22.0"
    }
  }

  backend "s3" {
    bucket         = "s3-aws-llabs-trf-state-prd"
    key            = "s3backend/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "dyndb-aws-llabs-trf-state-prd"
    encrypt        = true
    profile        = "default"
  }
}