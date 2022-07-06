[
  {
    "name": "nginx-auth-proxy",
    "image": "${nginx_auth_proxy_image}",
    "essential": true,
    "cpu": ${nginx_auth_proxy_cpu_units},
    "memory": ${nginx_auth_proxy_memory_units},
    "portMappings": [
      {
        "containerPort": 443,
        "hostPort": 443,
        "protocol": "tcp"
      },
      {
        "containerPort": 80,
        "hostPort": 80,
        "protocol": "tcp"
      }
    ],
    "environment": [
      {
        "name": "CJSE_NGINX_DNS_RESOLVER",
        "value": "${dns_resolver}"
      },
      {
        "name": "CJSE_NGINX_BICHARDBACKEND_DOMAIN",
        "value": "${bichard_backend_domain}"
      },
      {
        "name": "CJSE_NGINX_APP_DOMAIN",
        "value": "${bichard_domain}"
      },
      {
        "name": "CJSE_NGINX_USERSERVICE_DOMAIN",
        "value": "${user_service_domain}"
      },
      {
        "name": "CJSE_NGINX_UI_DOMAIN",
        "value": "${ui_domain}"
      },
      {
        "name": "CJSE_NGINX_AUDITLOGGING_DOMAIN",
        "value": "${audit_logging_domain}"
      },
      {
        "name": "CJSE_NGINX_STATICSERVICE_DOMAIN",
        "value": "${static_service_domain}"
      }
    ],
    "dependsOn": [],
    "mountPoints": [],
    "environmentFiles": [],
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
