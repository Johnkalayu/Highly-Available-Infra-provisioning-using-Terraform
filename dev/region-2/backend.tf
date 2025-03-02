terraform {
  backend "s3" {
    name = "dev-region2-terrafrom-state-file"
    region = "ap-southeast-2"
    key = "terraform-module/region2/terraform.state"
    dynamodb_table = "dev-terraform-lock-region2"
    encrypt = true

  }

  required_providers {
    aws = {
        source = "hasicorp/aws"
        version = "~>5.0"
    }
  }
}