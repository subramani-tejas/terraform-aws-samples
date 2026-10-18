# sample hex output: ed2debbf
resource "random_id" "bucket_suffix" {
  byte_length = 4
}

# randomized suffix to bucket name to prevent global namespace collisions
resource "aws_s3_bucket" "catpics" {
  bucket = "catpics-${random_id.bucket_suffix.hex}"
}

# Enforced S3 Public Access Block
resource "aws_s3_bucket_public_access_block" "catpics" {
  bucket                  = aws_s3_bucket.catpics.id
  block_public_acls       = true
  ignore_public_acls      = true
  block_public_policy     = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket" "animalpics" {
  bucket = "animalpics-${random_id.bucket_suffix.hex}"
}

resource "aws_s3_bucket_public_access_block" "animalpics" {
  bucket                  = aws_s3_bucket.animalpics.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}
