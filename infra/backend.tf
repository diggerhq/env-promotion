terraform {
  backend "s3" {
    bucket         = var.terraform_backend_bucket
    key            = var.terraform_backend_key
    region         = var.terraform_backend_region
    dynamodb_table = var.terraform_backend_dynamodb_table
  }
}

