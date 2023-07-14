locals {
  cloud_web_secrets = [
    { "key" : "JWT_PUBLIC_KEY", "value" : "arn:aws:ssm:${var.aws_region}:${var.aws_account_id}:parameter/cloud-infra/jwt-public-key" },
    { "key" : "WEBHOOK_SECRET", "value" : "arn:aws:ssm:${var.aws_region}:${var.aws_account_id}:parameter/cloud-infra/webhook-secret" }
  ]
}

