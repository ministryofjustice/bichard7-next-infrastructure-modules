[
  {
    "name": "ui",
    "image": "${ui_image}",
    "essential": true,
    "cpu": ${ui_cpu_units},
    "memory": ${ui_memory_units},
    "portMappings": [
      {
        "containerPort": 443,
        "hostPort": 443,
        "protocol": "tcp"
      }
    ],
    "environment": [],
    "dependsOn": [],
    "mountPoints": [],
    "environmentFiles": [],
    "secrets": [],
    "logConfiguration": {
      "logDriver": "awslogs",
      "options": {
        "awslogs-group": "${log_group}",
        "awslogs-region": "${region}",
        "awslogs-stream-prefix": "${log_stream_prefix}"
      }
    }
  }
]
