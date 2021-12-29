[
  {
    "name": "beanconnect",
    "image": "${beanconnect_image}",
    "essential": true,
    "cpu": ${cpu_units/2},
    "memory": ${memory_units},
    "portMappings": [
      {
        "containerPort": 31004,
        "hostPort": 31004,
        "protocol": "tcp"
      }
    ],
    "environment": [
      {
        "name": "BC_EIS_LISTENER_PORT",
        "value": "${listener_port}"
      },
      {
        "name": "BC_EIS_HOST",
        "value": "${eis_host}"
      },
      {
        "name": "BC_EIS_TSEL",
        "value": "${eis_tsel}"
      },
      {
         "name": "BC_PROXY_HOSTNAME",
         "value": "${proxy_host_name}"
      },
      {
        "name": "BC_EIS_LPAP",
        "value": "${pnc_lpap}"
      },
      {
        "name": "BC_EIS_AEQ",
        "value": "${pnc_aeq}"
      },
      {
        "name": "BC_CONTWIN",
        "value": "${pnc_contwin}"
      },
      {
        "name": "SETUP_HOSTS_FILE",
        "value": "${setup_hosts_file}"
      },
      {
        "name": "TAC_SUFFIX",
        "value": "${tac_suffix}"
      }
    ],
    "environmentFiles": [],
    "secrets": [
      {
        "name": "BC_ADMIN_PASSWORD",
        "valueFrom": "${password_arn}"
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
