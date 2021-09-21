provider "aws" {
  region = "ap-northeast-2"
}

terraform {
  backend "s3" {
    key = "global/s3/terraform.tfstate"
  }
}

resource "aws_s3_bucket" "terraform_state" {
  bucket = "sssaang-terraform-history-s3-bucket-name"

  # gurantees s3 does not get destroyed by mistake
  lifecycle {
    prevent_destroy = true
  }

  # enabling versioning in order to track the history
  versioning {
    enabled = true
  }

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }
}

resource "aws_dynamodb_table" "terraform_locks" {
  name = "terraform-up-and-running-locks"
  billing_mode = "PAY_PER_REQUEST"
  hash_key = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }
}

output "s3_bucket_arn" {
  value = aws_s3_bucket.terraform_state.arn
  description = "The ARN of the S3 bucket"
}

output "dynamodb_table_name" {
  value = aws_dynamodb_table.terraform_locks.name
  description = "The ARN of the S3 bucket"
}