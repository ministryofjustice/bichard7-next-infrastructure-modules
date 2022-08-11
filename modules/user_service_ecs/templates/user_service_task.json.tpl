[
  {
    "name": "user-service",
    "image": "${user_service_image}",
    "essential": true,
    "cpu": ${user_service_cpu_units},
    "memory": ${user_service_memory_units},
    "portMappings": [
      {
        "containerPort": 443,
        "hostPort": 443,
        "protocol": "tcp"
      }
    ],
    "environment": [
      {
        "name": "BASE_URL",
        "value": "${base_url}"
      },
      {
        "name": "BICHARD_REDIRECT_URL",
        "value": "${bichard_redirect_url}"
      },
      {
        "name": "NEW_BICHARD_REDIRECT_URL",
        "value": "${new_bichard_redirect_url}"
      },
      {
        "name": "AUDIT_LOGGING_URL",
        "value": "${audit_logging_url}"
      },
      {
        "name": "DB_HOST",
        "value": "${db_host}"
      },
            {
        "name": "DB_SSL",
        "value": "${db_ssl}"
      },
      {
        "name": "DB_USER",
        "value": "${db_user}"
      },
      {
        "name": "INCORRECT_DELAY",
        "value": "${incorrect_delay}"
      },
      {
        "name": "TOKEN_EXPIRES_IN",
        "value": "${token_expires_in}"
      },
      {
        "name": "EMAIL_FROM",
        "value" : "${email_from}"
      },
      {
        "name": "SMTP_HOST",
        "value" : "${smtp_host}"
      },
      {
        "name": "SMTP_USER",
        "value" : "${smtp_user}"
      },
      {
        "name": "SMTP_PASSWORD",
        "value" : "${smtp_password}"
      },
      {
        "name": "SMTP_TLS",
        "value" : "${smtp_tls}"
      },
      {
        "name": "SMTP_PORT",
        "value" : "${smtp_port}"
      },
      {
        "name": "COOKIES_SECURE",
        "value" : "${cookies_secure}"
      },
      {
        "name": "HIDE_NON_PROD_BANNER",
        "value": "${hide_non_prod_banner}"
      }
    ],
    "dependsOn": [],
    "mountPoints": [],
    "environmentFiles": [],
    "secrets": [
      {
        "name": "DB_PASSWORD",
        "valueFrom": "${db_password_arn}"
      },
      {
        "name": "TOKEN_SECRET",
        "valueFrom": "${jwt_secret_arn}"
      },
      {
        "name": "COOKIE_SECRET",
        "valueFrom": "${cookie_secret_arn}"
      },
      {
        "name": "CSRF_COOKIE_SECRET",
        "valueFrom": "${csrf_cookie_secret_arn}"
      },
      {
        "name": "CSRF_FORM_SECRET",
        "valueFrom": "${csrf_form_secret_arn}"
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
