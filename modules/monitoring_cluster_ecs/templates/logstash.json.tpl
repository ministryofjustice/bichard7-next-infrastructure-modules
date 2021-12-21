[
  {
    "name": "logstash",
    "image": "${logstash_image}",
    "essential": true,
    "cpu": ${application_cpu},
    "memory": ${application_memory},
    "dependsOn": [],
    "mountPoints": [],
    "portMappings": [
      {
        "containerPort": 9600,
        "hostPort": 9600,
        "protocol": "tcp"
      }
    ],
    "environment": [
      {
        "name": "LOG_LEVEL",
        "value": "debug"
      },
      {
        "name": "LOG_FORMAT",
        "value": "json"
      },
      {
        "name": "CJSE_ENVIRONMENT",
        "value": "${environment}"
      },
      {
        "name": "CJSE_LOGSTASH_ES_DOMAIN",
        "value": "https://${elasticsearch_host}:443"
      },
      {
        "name": "CJSE_LOGSTASH_ES_USERNAME",
        "value": "${es_username}"
      },
      {
        "name": "CJSE_LOGSTASH_LOGLEVEL",
        "value": "${log_level}"
      }
    ],
    "environmentFiles": [],
    "secrets": [
      {
        "name": "CJSE_LOGSTASH_ES_PASSWORD",
        "valueFrom": "${es_password_arn}"
      }
    ],
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
