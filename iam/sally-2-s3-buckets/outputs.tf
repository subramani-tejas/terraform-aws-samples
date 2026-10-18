output "catpicsbucketname" {
  description = "Bucketname for catpictures (the best animal!)"
  value       = aws_s3_bucket.catpics.id
}

output "animalpicsbucketname" {
  description = "Bucketname for animalpics (the almost best animals!)"
  value       = aws_s3_bucket.animalpics.id
}

output "sallyusername" {
  description = "IAM Username for Sally"
  value       = aws_iam_user.sally.name
}
