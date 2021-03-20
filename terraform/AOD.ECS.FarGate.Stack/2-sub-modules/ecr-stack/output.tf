output "nike-ecr" {
    description = "ECR Repository URL for Nike"
    value = aws_ecr_repository.nike_ecr.repository_url


}

output "defib-ecr" {
    description = "ECR Repository URL for Defib"
    value = aws_ecr_repository.defib_ecr.repository_url
    

}