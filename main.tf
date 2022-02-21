provider "aws" {
  region  = "us-east-1"
}

terraform {
  backend "s3" {
    bucket         = "terraform-state.uq5xdmsuq"
    key            = "github-actions-demo.terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-state-lock"
  }

  required_providers {
    aws = {
      version = "~> 4"
      source  = "hashicorp/aws"
    }
  }
}

resource "aws_sqs_queue" "terraform_queue" {
  name                      = "terraform-example-queue"
  delay_seconds             = 60
  max_message_size          = 2048
  message_retention_seconds = 86400
  receive_wait_time_seconds = 10
}
