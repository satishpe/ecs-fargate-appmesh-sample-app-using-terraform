/*
provider "aws" {
  region  = "us-east-2"
}
*/



resource "aws_service_discovery_service" "nike" {
  name = "nike"
   // name = "nike.${var.service_domain}"

   dns_config {
     namespace_id = aws_service_discovery_private_dns_namespace.main.id
     dns_records {
       ttl  = 10
       type = "A"
     }
     routing_policy = "MULTIVALUE"
   }
  # dns_config {
  #   namespace_id = aws_service_discovery_private_dns_namespace.main.id
  #   dns_records {
  #     ttl  = 10
  #     type = "CNAME"
  #   }
  #   routing_policy = "WEIGHTED"
  # }



  health_check_custom_config {
    failure_threshold = 1
  }
}

resource "aws_appmesh_virtual_node" "nike" {
  name      = "nike"
  mesh_name = aws_appmesh_mesh.main.name
  spec {   
    listener {
      port_mapping {
        port     = var.nike_svc_port
        protocol = "http"
      }
      health_check {
        port     = var.nike_svc_port
        protocol            = "http"
        path                = "/api/Healthcheck"
        healthy_threshold   = 2
        unhealthy_threshold = 2
        timeout_millis      = 2000
        interval_millis     = 5000
      }

    }
    service_discovery {
      aws_cloud_map {
        service_name   = aws_service_discovery_service.nike.name
        namespace_name = aws_service_discovery_private_dns_namespace.main.name
      }
    }

   backend {
     virtual_service {
       //virtual_service_name = aws_appmesh_virtual_service.defib.name
       //virtual_service_name = aws_service_discovery_service.defib.name
       virtual_service_name = "defib.apm.aod2.dev.local"
     }

     

   }
  }

}

resource "aws_appmesh_virtual_router" "nike" {
  name      = "nike-router"
  mesh_name = aws_appmesh_mesh.main.name
  spec {
    listener {
      port_mapping {
        port     = "80"
        protocol = "http"
      }
    }
  }
}

resource "aws_appmesh_route" "nike" {
  name                = "nike-route"
  mesh_name           = aws_appmesh_mesh.main.name
  virtual_router_name = aws_appmesh_virtual_router.nike.name

 spec {
    http_route {
      match {
        prefix = "/"
      }

      retry_policy {
        http_retry_events = [
          "server-error",
        ]
        max_retries = 1

        per_retry_timeout {
          unit  = "s"
          value = 15
        }
      }


      action {
        weighted_target {
          virtual_node = aws_appmesh_virtual_node.nike.name
          weight       = var.nike_blue_percent
        }
        weighted_target {
          virtual_node = aws_appmesh_virtual_node.nike-green.name
          weight       = var.nike_green_percent
        }

      }
    }
  }
}


resource "aws_appmesh_virtual_service" "nike" {
  name      = "nike.appmesh.${var.service_domain}"
  mesh_name = aws_appmesh_mesh.main.name
  spec {
    provider {
      virtual_router {
        virtual_router_name = aws_appmesh_virtual_router.nike.name
      }
    }
  }
}

module "nike" {
  source            = "./../"
  region            = var.region
  app_name          = "nike"
  app_port          = var.nike_svc_port
  env               = var.Environment
  vpc               = module.vpc
  //app_image         = "226767807331.dkr.ecr.us-west-2.amazonaws.com/colorteller:latest"
  app_image         = "${var.ecr_url}/${var.nike_ecr_img}:${var.Environment}"
  cloudmap_service  = aws_service_discovery_service.nike
  aws_appmesh_virtual_node = aws_appmesh_virtual_node.nike.name
  appmesh           = aws_appmesh_mesh.main
  prefix            = var.Stack
  tags              = var.tags
  ecsCluster        = var.ecsCluster
  min_app_count     = var.nike_min_task
  ssm_splunk_url = var.ssm_splunk_url
  ssm_splunk_token = var.ssm_splunk_token
}