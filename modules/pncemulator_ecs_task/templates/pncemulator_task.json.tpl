[
  {
    "name": "pncemulator",
    "image": "${pncemulator_image}",
    "essential": true,
    "cpu": ${cpu_units/2},
    "memory": ${memory_units},
    "portMappings": [
      {
        "containerPort": 30001,
        "hostPort": 30001,
        "protocol": "tcp"
      },
      {
        "containerPort": 3000,
        "hostPort": 3000,
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
        "awslogs-stream-prefix": "${log_stream_prefix}"
      }
    }
  }
]
