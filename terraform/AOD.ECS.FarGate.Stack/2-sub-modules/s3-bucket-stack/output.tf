output "staging-bucket_id_file" {
    description = "S3 bucket name for File processing"
    value = aws_s3_bucket.bucket3.id

}

output "staging-bucket_arn_file" {
    description = "S3 bucket ARN for File processing"
    value = aws_s3_bucket.bucket3.arn

}

output "bucket_id_file" {
    description = "S3 bucket name for File processing"
    value = aws_s3_bucket.bucket4.id

}

output "bucket_arn_file" {
    description = "S3 bucket ARN for File processing"
    value = aws_s3_bucket.bucket4.arn

}