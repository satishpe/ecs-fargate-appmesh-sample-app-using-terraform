/*
provider "aws" {
  region  = "us-east-2"
}
*/



resource "aws_service_discovery_service" "defib-green" {
  name = "defib-green"
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

resource "aws_appmesh_virtual_node" "defib-green" {
  name      = "defib-green"
  mesh_name = aws_appmesh_mesh.main.name
  spec {   
    listener {
      port_mapping {
        port     = var.defib_svc_port
        protocol = "http"
      }
      health_check {
        port     = var.defib_svc_port
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
        service_name   = aws_service_discovery_service.defib-green.name
        namespace_name = aws_service_discovery_private_dns_namespace.main.name
      }
    }

   # backend {
   #   virtual_service {
   #     virtual_service_name = aws_service_discovery_service.defib.name
   #   }

     

   #}
  }

}

 resource "aws_appmesh_virtual_router" "defib-green" {
   name      = "defib-router-green"
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

resource "aws_appmesh_route" "defib-green" {
  name                = "defib-route-green"
  mesh_name           = aws_appmesh_mesh.main.name
  virtual_router_name = aws_appmesh_virtual_router.defib-green.name

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
          virtual_node = aws_appmesh_virtual_node.defib-green.name
          weight       = 1
        }

      }
    }
  }
}


resource "aws_appmesh_virtual_service" "defib-green" {
  name      = "defib-green.appmesh.${var.service_domain}"
  mesh_name = aws_appmesh_mesh.main.name
  spec {
    provider {
      virtual_router {
        virtual_router_name = aws_appmesh_virtual_router.defib-green.name
      }
    }
  }
}

module "defib-green" {
  source            = "./../"
  region            = var.region
  app_name          = "defib-green"
  app_port          = var.defib_svc_port
  env               = var.Environment
  vpc               = module.vpc
  //app_image         = "226767807331.dkr.ecr.us-west-2.amazonaws.com/colorteller:latest"
  //app_image         = "${var.ecr_url}/${var.defib_ecr_img}:${var.Environment}-green"
  app_image         = "${var.ecr_url}/${var.defib_ecr_img}:2"
  cloudmap_service  = aws_service_discovery_service.defib-green
  aws_appmesh_virtual_node = aws_appmesh_virtual_node.defib-green.name
  appmesh           = aws_appmesh_mesh.main
  prefix            = var.Stack
  tags              = var.tags
 // ecsCluster        = "${var.ecsCluster}-green"
  ecsCluster        = var.ecsCluster
  min_app_count     = var.defib_green_min_task
  ssm_splunk_url = var.ssm_splunk_url
  ssm_splunk_token = var.ssm_splunk_token
}