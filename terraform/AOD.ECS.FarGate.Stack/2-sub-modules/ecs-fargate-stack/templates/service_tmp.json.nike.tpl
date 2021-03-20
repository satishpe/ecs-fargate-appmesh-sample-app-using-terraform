[
  {
    "name": "${prefix}-${env}-${app_name}",
    "image": "${app_image}",
    "cpu": ${fargate_cpu},
    "memory": ${fargate_memory},
    "networkMode": "awsvpc",
    ${logconfig},
    "portMappings": [
      {
        "hostPort": ${app_port},
        "containerPort": ${app_port}
      }
      ${extra_ports}
    ],
    "dependsOn": [
      {
        "containerName": "envoy",
        "condition": "HEALTHY"
      }
    ],
    "ulimits": [
      {
        "softLimit": 50000,
        "hardLimit": 50000,
        "name": "nofile"
      }
    ],
    "environment":
     [
      { "name" : "ENVIRONMENT", "value" : "poc" },
      { "name" : "STACK_NAME", "value" : "awsxmpl" },
      { "name" : "AWS_XRAY_DAEMON_ADDRESS", "value" : "xray-daemon:2000" },
      { "name" : "ASPNETCORE_URLS", "value" : "http://+:${app_port}" },
      { "name" : "RELOAD_CONFIG_AFTER", "value" : "15" }


    ],
    "secrets": [${secrets}]
  },
  {
    "name": "envoy",
    "image": "${envoy_proxy_image}",
    "essential": true,
    "networkMode": "awsvpc",
    "memoryReservation": 256,
    "environment": [
      {
        "name": "APPMESH_VIRTUAL_NODE_NAME",
        "value": "mesh/${mesh_name}/virtualNode/${virtual_node_name}"
      },
      { "name" : "AWS_XRAY_DAEMON_ADDRESS", "value" : "xray-daemon:2000" }
    ],  
    "portMappings": [
        {
          "hostPort": 9901,
          "protocol": "tcp",
          "containerPort": 9901
        }
    ],
    "healthCheck": {
      "command": [
        "CMD-SHELL",
        "curl -s http://localhost:9901/server_info | grep state | grep -q LIVE"
      ],
      "startPeriod": 10,
      "interval": 5,
      "timeout": 2,
      "retries": 3
    },
    "user": "1337",
    ${logconfig},
    "ulimits": [
      {
        "softLimit": 15000,
        "hardLimit": 15000,
        "name": "nofile"
      }
    ]
  }
  ${xray}
]