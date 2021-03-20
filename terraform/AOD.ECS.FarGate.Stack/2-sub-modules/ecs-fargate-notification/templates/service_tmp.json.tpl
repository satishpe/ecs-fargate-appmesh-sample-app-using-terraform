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
    ]
  }
]