terraform {
  backend "s3" {
    name = "prod-region1-terraform-state-file"
    region = "ap-southeast-2"
    key = "terraform-module/region1/terraform.state"
    dynamodb_table = "prod-terraform-lock-region1"
    encrypt = true

  }

  required_providers {
    aws = {
        source = "hasicorp/aws"
        version = "~>5.0"
    }
  }
}