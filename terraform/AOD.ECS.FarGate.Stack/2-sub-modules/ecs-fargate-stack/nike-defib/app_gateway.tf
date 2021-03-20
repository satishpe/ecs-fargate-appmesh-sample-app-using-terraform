

resource "aws_service_discovery_service" "envoy_proxy" {
  name = "gateway"
//name = "gateway.${var.service_domain}"
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

resource "aws_appmesh_virtual_gateway" "vgateway" {
  name      = "${var.envPrefixName}-vg"
  mesh_name = aws_appmesh_mesh.main.name

  spec {
    listener {
      port_mapping {
        port     = var.nike_svc_port
        protocol = "http"
      }

      health_check {
        port                = var.nike_svc_port
        protocol            = "http"
        path                = "/api/Healthcheck"
        healthy_threshold   = 2
        unhealthy_threshold = 2
        timeout_millis      = 2000
        interval_millis     = 5000
      }

    }
  }
}

resource "aws_appmesh_gateway_route" "route" {
  name                 = "${var.envPrefixName}-route"
  virtual_gateway_name = aws_appmesh_virtual_gateway.vgateway.name
  mesh_name            = aws_appmesh_mesh.main.name
  spec {
    http_route {
      action {
        target {
          virtual_service {
            virtual_service_name = aws_appmesh_virtual_service.nike.name
          }
        }
      }

      match {
        prefix = "/"
      }
    }
  }
}

// add envoy proxy 
module "envoy-proxy" {
  source            = "./../"
  region            = var.region
  app_name          = "nike-gateway"
  app_port          = var.nike_svc_port
  //app_port          = "80"
  env               = var.Environment
  vpc               = module.vpc
  //vpc               = data.aws_vpc.selected.id
  cloudmap_service  = aws_service_discovery_service.envoy_proxy
  appmesh           = aws_appmesh_mesh.main
  virtual_gateway   = "${var.envPrefixName}-vg"
  prefix            = var.Stack
  tags              = var.tags
  ecsCluster        = var.ecsCluster
  min_app_count     = var.gateway_min_task
  ssm_splunk_url = var.ssm_splunk_url
  ssm_splunk_token = var.ssm_splunk_token
}