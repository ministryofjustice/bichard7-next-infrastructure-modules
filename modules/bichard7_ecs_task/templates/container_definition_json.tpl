[
   {
      "name":"${APP_NAME}",
      "cpu":${CPU},
      "essential":true,
      "image":"${REPOSITORY_URL}@${IMAGE_TAG}",
      "memory":${MEMORY},
      "memoryReservation":64,
      "portMappings":[
         {
            "containerPort":9043,
            "hostPort":9043,
            "protocol":"tcp"
         },
         {
            "containerPort":9443,
            "hostPort":9443,
            "protocol":"tcp"
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
           "name": "MQ_USER",
           "value": "${MQ_USER}"
        },
        {
           "name": "MQ_CONN_STR",
           "value": "${MQ_CONN_STR}"
        },
        {
           "name": "MQ_TYPE",
           "value": "activemq"
        },
        {
           "name": "LOG_LEVEL",
           "value": "${LOG_LEVEL}"
        },
        {
           "name": "LOG_PNC_REQUESTS",
           "value": "${LOG_PNC_REQUESTS}"
        },
        {
          "name": "DB_SSL",
          "value": "${DB_SSL}"
        },
        {
          "name": "DB_SSL_MODE",
          "value": "${DB_SSL_MODE}"
        },
        {
          "name": "DB_TYPE",
          "value": "postgres"
        },
        {
          "name": "BC_PROXY_URL",
          "value": "${BC_PROXY_URL}"
        },
        {
          "name": "HEALTH_CHECK_TAC",
          "value": "${HEALTH_CHECK_TAC}"
        },
        {
          "name": "ENVIRONMENT",
          "value": "${DEPLOY_ENV}"
        },
        {
          "name": "TAC_SUFFIX",
          "value": "${TAC_SUFFIX}"
        },
        {
          "name": "DISABLE_MDB",
          "value": "${DISABLE_MDB}"
        },
        {
          "name": "AUDIT_LOGGING_API_URL",
          "value": "${AUDIT_LOGGING_API_URL}"
        },
        {
           "name": "WLP_LOGGING_CONSOLE_LOGLEVEL",
           "value": "${LOG_LEVEL}"
        },
        {
           "name": "WLP_LOGGING_MESSAGE_FORMAT",
           "value": "json"
        },
        {
           "name": "WLP_LOGGING_MESSAGE_SOURCE",
           "value": "message,trace,accessLog,ffdc,audit"
        },
        {
           "name": "WLP_LOGGING_CONSOLE_FORMAT",
           "value": "json"
        },
        {
           "name": "WLP_LOGGING_CONSOLE_SOURCE",
           "value": "message,trace,accessLog,ffdc,audit"
        },
        {
           "name": "WLP_LOGGING_APPS_WRITE_JSON",
           "value": "true"
        },
        {
           "name": "PROCESSING_VALIDATION_PERCENTAGE",
           "value": "100"
        }
      ],
      "secrets": ${SECRETS},
      "logConfiguration": {
          "logDriver": "awslogs",
          "options": {
              "awslogs-group": "${LOG_GROUP}",
              "awslogs-region": "eu-west-2",
              "awslogs-stream-prefix": "${LOG_STREAM_PREFIX}"
          }
      }
   }
]
