    "logConfiguration": {
      "logDriver": "awslogs",
      "options": {
        "awslogs-group": "/ecs/${prefix}-${env}-${app_name}",
        "awslogs-region": "${aws_region}",
        "awslogs-stream-prefix": "${app_name}"
      }
    }