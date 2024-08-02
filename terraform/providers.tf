provider "aws" {
  region     = var.aws_region
  access_key = $access_key
  secret_key = $secret_key
}
