# Bucket for DXS File Staging 
resource "aws_s3_bucket" "bucket3" {
  bucket = "${var.envPrefix}-document-staging"
  acl    = "private"

  tags =  var.resourceTags
  
}

# Bucket for DXS File Repository 
resource "aws_s3_bucket" "bucket4" {
  bucket = "${var.envPrefix}-document-repository"
  acl    = "private"

  tags =  var.resourceTags
  
}