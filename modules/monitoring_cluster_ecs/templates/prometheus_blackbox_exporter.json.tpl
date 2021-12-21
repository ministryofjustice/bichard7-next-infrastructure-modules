[
  {
    "name": "prometheus_blackbox_exporter",
    "image": "${prometheus_blackbox_exporter_image}",
    "essential": true,
    "cpu": ${application_cpu},
    "memory": ${application_memory},
    "user": "root",
    "dependsOn": [
    ],
    "mountPoints": [
    ],
    "portMappings": [
      {
        "containerPort": 9116,
        "hostPort": 9116,
        "protocol": "tcp"
      }
    ],
    "environment": [],
    "environmentFiles": [],
    "secrets": [],
    "logConfiguration": {
      "logDriver": "awslogs",
      "options": {
        "awslogs-group": "${log_group}",
        "awslogs-region": "${region}",
        "awslogs-stream-prefix": "${blackbox_exporter_log_stream_prefix}"
      }
    }
  }
]
