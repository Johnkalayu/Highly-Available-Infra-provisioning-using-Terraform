terraform {
  backend "s3" {
    name = "dev-region1-terrafrom-state-file"
    region = "ap-southeast-2"
    key = "terraform-module/region1/terraform.state"
    dynamodb_table = "dev-region1-tf-lock"
    encrypt = true

  }

  required_providers {
    aws = {
        source = "hasicorp/aws"
        version = "~>5.0"
    }
  }
}