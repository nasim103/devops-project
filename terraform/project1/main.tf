resource "random_id" "bucket-suffix" {
 byte_length = 6
}

resource "aws_s3_bucket" "example-us" {
    bucket = "my-us-bucket-${random_id.bucket-suffix.dec}"
}

resource "aws_s3_bucket" "example-eu" {
    bucket = "my-eu-bucket-${random_id.bucket-suffix.hex}"
    provider = aws.eu-west
  
}