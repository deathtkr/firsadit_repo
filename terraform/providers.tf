provider "aws" {
  region     = var.aws_region
  access_key = $AWS_access
  secret_key = $AWS_secret
}
