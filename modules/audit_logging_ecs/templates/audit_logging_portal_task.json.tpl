[
  {
    "name": "audit_logging",
    "image": "${audit_logging_image}",
    "essential": true,
    "cpu": ${cpu_units},
    "memory": ${memory_units},
    "portMappings": [
      {
        "containerPort": 443,
        "hostPort": 443,
        "protocol": "tcp"
      }
    ],
    "environment": [
      {
        "name": "API_URL",
        "value": "${api_url}"
      }
    ],
    "dependsOn": [],
    "mountPoints": [],
    "environmentFiles": [],
    "secrets": [
      {
        "name": "API_KEY",
        "valueFrom": "${api_key_arn}"
      }
    ],
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
