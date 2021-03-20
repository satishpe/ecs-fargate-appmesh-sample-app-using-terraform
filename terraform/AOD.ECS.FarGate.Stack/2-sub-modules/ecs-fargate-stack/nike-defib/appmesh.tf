
resource "aws_appmesh_mesh" "main" {
  name = "${var.envPrefixName}-mesh"
  spec {
    egress_filter {
      type = "DROP_ALL"
    }
  

  }

  tags              = var.tags
}


resource "aws_service_discovery_private_dns_namespace" "main" {
  name        = var.service_domain
  description = "all services will be registered under this common namespace"
  vpc         = module.vpc.vpc_id
}
