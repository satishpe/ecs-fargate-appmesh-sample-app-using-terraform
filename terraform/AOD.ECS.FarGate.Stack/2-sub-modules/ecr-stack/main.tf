resource "aws_ecr_repository" "nike_ecr" {
  name                 = "${var.envPrefix}-nike-ecr"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }

   tags = var.resourceTags
}

resource "aws_ecr_repository" "defib_ecr" {
  name                 = "${var.envPrefix}-defib-ecr"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }

   tags = var.resourceTags
}

/* 
resource "aws_ecr_repository" "scheduler_ecr" {
  name                 = "${var.envPrefix}-scheduler-ecr"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }

   tags = var.resourceTags
}

resource "aws_ecr_repository" "notification_ecr" {
  name                 = "${var.envPrefix}-notification-ecr"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }

   tags = var.resourceTags
}

resource "aws_ecr_repository" "notification_batch_ecr" {
  name                 = "${var.envPrefix}-notification-batch-ecr"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }

   tags = var.resourceTags
}



// create aws_ecs_cluster - Blue of B/G Deployment
resource "aws_ecs_cluster" "main" {
  // set name for ecs cluster
  name = var.ecsCluster
  // set tags for cluster
  tags = var.tags
}

*/