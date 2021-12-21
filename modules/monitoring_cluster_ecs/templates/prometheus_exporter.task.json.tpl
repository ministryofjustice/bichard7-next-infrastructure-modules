[
  {
    "name": "prometheus_cloudwatch_exporter",
    "image": "${prometheus_cloudwatch_exporter_image}",
    "essential": true,
    "cpu":${application_cpu},
    "memory":${application_memory},
    "dependsOn": [],
    "mountPoints": [],
    "portMappings": [
      {
        "containerPort": 9106,
        "hostPort": 9106,
        "protocol": "tcp"
      }
    ],
    "environment": [
      {
        "name": "AWS_DEFAULT_REGION",
        "value": "${region}"
      }
    ],
    "environmentFiles": [],
    "secrets": [],
    "logConfiguration": {
      "logDriver": "awslogs",
      "options": {
        "awslogs-group": "${log_group}",
        "awslogs-region": "${region}",
        "awslogs-stream-prefix": "${exporter_log_stream_prefix}"
      }
    }
  }
]
