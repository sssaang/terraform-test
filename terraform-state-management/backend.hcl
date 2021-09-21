# terraform init -backend-config=backend.hcl
bucket = "sssaang-terraform-history-s3-bucket-name"
region = "ap-northeast-2"
dynamodb_table = "terraform-up-and-running-locks"
encrypt = true