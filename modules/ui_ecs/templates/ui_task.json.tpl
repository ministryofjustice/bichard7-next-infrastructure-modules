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
    "environment": [
        {
           "name": "DB_USER",
           "value": "${DB_USER}"
        },
        {
           "name": "DB_HOST",
           "value": "${DB_HOST}"
        },
        {
           "name": "DB_SSL",
           "value": "${DB_SSL}"
        },
        {
           "name": "MQ_USER",
           "value": "${MQ_USER}"
        },
        {
           "name": "MQ_PASSWORD",
           "value": "${MQ_PASSWORD}"
        },
        {
           "name": "MQ_URL",
           "value": "${MQ_URL}"
        }
    ],
    "dependsOn": [],
    "mountPoints": [],
    "environmentFiles": [],
    "secrets": ${SECRETS},
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
