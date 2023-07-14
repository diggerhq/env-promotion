terraform {
  backend "s3" {
    bucket         = "digger-terraform-state-209539466991"
    key            = "4b0cb767-cde5-469c-909c-5a34698d1bbb"
    region         = "us-east-1"
    dynamodb_table = "digger-terraform-state-lock"
  }
}