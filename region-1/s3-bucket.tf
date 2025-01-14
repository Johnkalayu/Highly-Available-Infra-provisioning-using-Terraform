resource "aws_s3_bucket" "s3_bucket" {
    bucket = "dev-region1-terraform-state-file"

}

resource "aws_dynamodb_table" "tf_lock" {
    name = "dev-region1-tf-lock"
    billing_mode = "PROVISIONED"
    hash_key = "LOCKID"

    attribute {
        name = "LockID"
        type = "s"
    }
}
