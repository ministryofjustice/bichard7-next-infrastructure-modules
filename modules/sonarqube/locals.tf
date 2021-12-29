locals {
  sonar_alb_name        = (length("${var.name}-sonar") > 32) ? trim(substr("${var.name}-sonar", 0, 32), "-") : "${var.name}-sonar"
  sonar_alb_name_prefix = lower(substr(replace("SQ${var.tags["Environment"]}", "-", ""), 0, 6))

  cloudwatch_alb_name        = (length("${var.name}-cwatch") > 32) ? trim(substr("${var.name}-cwatch", 0, 32), "-") : "${var.name}-cwatch"
  cloudwatch_alb_name_prefix = lower(substr(replace("C${var.tags["Environment"]}", "-", ""), 0, 6))

  sonar_data_dir = "/data"

  github_web_cidrs = [
    "192.30.252.0/22",
    "185.199.108.0/22",
    "140.82.112.0/20",
    "143.55.64.0/20",
    "13.230.158.120/32",
    "18.179.245.253/32",
    "52.69.239.207/32",
    "13.209.163.61/32",
    "54.180.75.25/32",
    "13.233.76.15/32",
    "13.234.168.60/32",
    "13.236.14.80/32",
    "13.238.54.232/32",
    "52.63.231.178/32",
    "20.201.28.148/32",
    "20.205.243.168/32",
    "102.133.202.248/32"
  ]

  github_git_cidrs = [
    "192.30.252.0/22",
    "185.199.108.0/22",
    "140.82.112.0/20",
    "143.55.64.0/20",
    "13.114.40.48/32",
    "52.192.72.89/32",
    "52.69.186.44/32",
    "15.164.81.167/32",
    "52.78.231.108/32",
    "13.234.176.102/32",
    "13.234.210.38/32",
    "13.236.229.21/32",
    "13.237.44.5/32",
    "52.64.108.95/32",
    "20.201.28.151/32",
    "20.205.243.166/32",
    "102.133.202.242/32",
    "18.181.13.223/32",
    "54.238.117.237/32",
    "54.168.17.15/32",
    "3.34.26.58/32",
    "13.125.114.27/32",
    "3.7.2.84/32",
    "3.6.106.81/32",
    "52.63.152.235/32",
    "3.105.147.174/32",
    "3.106.158.203/32",
    "20.201.28.152/32",
    "20.205.243.160/32",
    "102.133.202.246/32"
  ]

  github_packages_cidrs = [
    "3.114.109.192/32",
    "3.114.74.150/32",
    "52.68.132.128/32",
    "52.79.52.209/32",
    "13.124.3.227/32",
    "13.235.209.61/32",
    "13.234.166.55/32",
    "3.105.68.105/32",
    "13.237.25.231/32",
    "13.55.142.41/32",
    "140.82.121.33/32",
    "140.82.121.34/32",
    "140.82.113.33/32",
    "140.82.113.34/32",
    "140.82.112.33/32",
    "140.82.112.34/32",
    "140.82.114.33/32",
    "140.82.114.34/32",
    "192.30.255.164/31",
    "20.201.28.144/32",
    "20.205.243.164/32",
    "102.133.202.243/32"
  ]
}