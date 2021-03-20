
/* create aws_ecs_cluster - Blue of B/G Deployment
resource "aws_ecs_cluster" "main" {
  // set name for ecs cluster
  name = var.ecsCluster
  // set tags for cluster
  tags = var.tags
}

*/

# // create aws_ecs_cluster - Green of B/G Deployment
# resource "aws_ecs_cluster" "green" {
#   // set name for ecs cluster
#   name = "${var.ecsCluster}-green"
#   // set tags for cluster
#   tags = var.tags
# }
