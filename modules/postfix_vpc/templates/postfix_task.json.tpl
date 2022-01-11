[
  {
    "name": "postfix",
    "image": "${postfix_image}",
    "essential": true,
    "cpu": ${cpu_units},
    "memory": ${memory_units},
    "portMappings": [
      {
        "containerPort": 25,
        "hostPort": 2525,
        "protocol": "tcp"
      },
      {
        "containerPort": 445,
        "hostPort": 4545,
        "protocol": "tcp"
      }
    ],
    "environment": [
      {
        "name": "CJSM_MAIL_HOSTNAME",
        "value": "${mail_hostname}"
      },
      {
        "name": "CJSM_MAIL_DOMAIN",
        "value": "${mail_domain}"
      },
      {
        "name": "CJSM_ALLOWED_CIDRS",
        "value": "${allowed_cidrs}"
      },
      {
        "name": "CJSM_POSTFIX_CIDRS",
        "value": "${postfix_cidrs}"
      },
      {
        "name": "CJSM_HOSTNAME",
        "value": "${cjsm_hostname}"
      }
    ],
    "environmentFiles": [],
    "secrets": [
      {
        "name": "CJSM_POSTFIX_RELAY_USER",
        "valueFrom": "${postfix_relay_user_arn}"
      },
      {
        "name": "CJSM_POSTFIX_RELAY_PASSWORD",
        "valueFrom": "${postfix_relay_password_arn}"
      },
      {
        "name": "CJSM_POSTFIX_CERTIFICATE",
        "valueFrom": "${postfix_certificate_arn}"
      },
      {
        "name": "CJSM_POSTFIX_KEY",
        "valueFrom": "${postfix_key_arn}"
      },
      {
        "name": "CJSM_ROOT_CERTIFICATE",
        "valueFrom": "${postfix_root_certificate_arn}"
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
