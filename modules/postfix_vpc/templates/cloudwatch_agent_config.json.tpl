{
  "agent": {
    "metrics_collection_interval": 10,
    "logfile": "/opt/aws/amazon-cloudwatch-agent/logs/amazon-cloudwatch-agent.log"
  },
  "metrics": {
    "namespace": "${service_name}/smtp",
    "metrics_collected": {
      "cpu": {
        "resources": [
          "*"
        ],
        "measurement": [
          {
            "name": "cpu_usage_idle",
            "rename": "CPU_USAGE_IDLE",
            "unit": "Percent"
          },
          {
            "name": "cpu_usage_nice",
            "unit": "Percent"
          },
          "cpu_usage_guest"
        ],
        "totalcpu": false,
        "metrics_collection_interval": 10,
        "append_dimensions": {
          "InstanceId": "$${aws:InstanceId}"
        }
      },
      "disk": {
        "resources": [
          "/",
          "/tmp"
        ],
        "measurement": [
          {
            "name": "free",
            "rename": "DISK_FREE",
            "unit": "Gigabytes"
          },
          "total",
          "used"
        ],
        "ignore_file_system_types": [
          "sysfs",
          "devtmpfs"
        ],
        "metrics_collection_interval": 60,
        "append_dimensions": {
          "InstanceId": "$${aws:InstanceId}"
        }
      },
      "diskio": {
        "resources": [
          "*"
        ],
        "measurement": [
          "reads",
          "writes",
          "read_time",
          "write_time",
          "io_time"
        ],
        "metrics_collection_interval": 60,
        "append_dimensions": {
          "InstanceId": "$${aws:InstanceId}"
        }
      },
      "swap": {
        "measurement": [
          "swap_used",
          "swap_free",
          "swap_used_percent"
        ]
      },
      "mem": {
        "measurement": [
          "mem_used",
          "mem_cached",
          "mem_total"
        ],
        "metrics_collection_interval": 10,
        "append_dimensions": {
          "InstanceId": "$${aws:InstanceId}"
        }
      },
      "net": {
        "resources": [
          "eth0"
        ],
        "measurement": [
          "bytes_sent",
          "bytes_recv",
          "drop_in",
          "drop_out"
        ]
      },
      "netstat": {
        "measurement": [
          "tcp_established",
          "tcp_syn_sent",
          "tcp_close"
        ],
        "metrics_collection_interval": 60,
        "append_dimensions": {
          "InstanceId": "$${aws:InstanceId}"
        }
      },
      "processes": {
        "measurement": [
          "running",
          "sleeping",
          "dead"
        ],
        "metrics_collection_interval": 60,
        "append_dimensions": {
          "InstanceId": "$${aws:InstanceId}"
        }
      }
    }
  },
  "logs": {
    "logs_collected": {
      "files": {
        "collect_list": [
          {
            "file_path": "/opt/aws/amazon-cloudwatch-agent/logs/amazon-cloudwatch-agent.log",
            "log_group_name": "/${service_name}/CloudWatchAgentLog/",
            "log_stream_name": "{instance_id}_{hostname}",
            "timezone": "Local"
          },
          {
            "file_path": "/var/log/messages",
            "log_group_name": "/${service_name}/var/log/messages",
            "log_stream_name": "{instance_id}_{hostname}",
            "timezone": "Local"
          },
          {
            "file_path": "/var/log/secure",
            "log_group_name": "/${service_name}/var/log/secure",
            "log_stream_name": "{instance_id}_{hostname}",
            "timezone": "Local"
          },
          {
            "file_path": "/var/log/yum.log",
            "log_group_name": "/${service_name}/var/log/yum",
            "log_stream_name": "{instance_id}_{hostname}",
            "timezone": "Local"
          },
          {
            "file_path": "/var/log/maillog",
            "log_group_name": "/${service_name}/var/log/maillog",
            "log_stream_name": "{instance_id}_{hostname}",
            "timezone": "Local"
          }
        ]
      }
    },
    "log_stream_name": "/ec2/catchall"
  }
}
