[
  {
      "name": "prometheus",
      "image": "${prometheus_image}",
      "essential": true,
      "cpu":${application_cpu},
      "memory":${application_memory},
      "ulimits": [
        {
          "name": "nofile",
          "hardLimit": 1024000,
          "softLimit": 102400
        }
      ],
      "volumesFrom": [],
      "mountPoints": [
        {
          "sourceVolume": "${data_volume}",
          "containerPath": "/prometheus"
        }
      ],
      "portMappings": [
        {
          "containerPort": 9090,
          "hostPort": 9090,
          "protocol": "tcp"
        },
        {
          "containerPort": 9092,
          "hostPort": 9092,
          "protocol": "tcp"
        },
        {
          "containerPort": 9088,
          "hostPort": 9088,
          "protocol": "tcp"
        }
      ],
      "environment": [
        {
          "name": "CJSE_FQDN_SUFFIX",
          "value": "${public_zone_name}"
        },
        {
          "name": "LOG_LEVEL",
          "value": "debug"
        },
        {
          "name": "SNS_FORWARDER_ARN_PREFIX",
          "value": "${sns_arn}"
        },
        {
          "name": "SNS_FORWARDER_DEBUG",
          "value": "true"
        },
        {
          "name": "CJSE_PROMETHEUS_CLOUDWATCH_EXPORTER_FQDN",
          "value": "${cloudwatch_exporter_url}"
        },
        {
          "name": "CJSE_PROMETHEUS_BLACKBOX_EXPORTER_FQDN",
          "value": "${blackbox_exporter_url}"
        },
        {
          "name": "CJSE_PROMETHEUS_ALERT_URL",
          "value": "${sns_exporter_url}"
        },
        {
          "name": "CJSE_PROMETHEUS_ALERT_SNSTOPIC",
          "value": "${sns_topic_name}"
        },
        {
          "name": "RETENTION_DAYS",
          "value": "${data_retention_days}"
        },
        {
          "name": "CJSE_PNC_PORT",
          "value": "${pnc_port}"
        },
        {
          "name": "CJSE_USE_SMTP_SERVICE",
          "value": "${use_smtp_server}"
        }
      ],
      "environmentFiles": [],
      "secrets": [
        {
          "name": "HTPASSWD",
          "valueFrom": "${htpasswd_arn}"
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
