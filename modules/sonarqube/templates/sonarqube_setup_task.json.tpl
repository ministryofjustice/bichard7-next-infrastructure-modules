[
  {
    "environment": [
      {
        "name": "SONAR_JDBC_URL",
        "value": "jdbc:postgresql://${sonardb_url}/${db_name}"
      }
    ],
    "secrets": [
      {
        "name": "SONAR_JDBC_USERNAME",
        "valueFrom": "${sonardb_username_arn}"
      },
      {
        "name": "SONAR_JDBC_PASSWORD",
        "valueFrom": "${sonardb_password_arn}"
      }
    ],
    "essential": true,
    "image": "${sonarqube_image}",
    "name": "sonarqube",
    "portMappings": [
      {
        "hostPort": 9000,
        "containerPort": 9000,
        "protocol": "tcp"
      }
    ],
    "logConfiguration": {
      "logDriver": "awslogs",
      "options": {
        "awslogs-group": "${log_group}",
        "awslogs-region": "${region}",
        "awslogs-stream-prefix": "${log_stream_prefix}"
      }
    },
    "ulimits": [
      {
        "name": "nofile",
        "softLimit": 65535,
        "hardLimit": 65535
      }
    ],
    "command": [
      "-Dsonar.search.javaAdditionalOpts=-Dnode.store.allow_mmap=false"
    ]
  }
]
