# tfsec:ignore:aws-vpc-no-public-egress-sgr
resource "aws_security_group_rule" "allow_all_outbound" {
  description = "Allow all outbound traffic"

  from_port = 0
  protocol  = -1
  to_port   = 0

  security_group_id = data.aws_security_group.prometheus_exporter_security_group.id
  type              = "egress"

  cidr_blocks = ["0.0.0.0/0"] #tfsec:ignore:AWS007
}

resource "aws_security_group_rule" "prometheus_exporter_scrape_ingress_from_prometheus" {
  description = "Allow prometheus scrape port access"

  from_port = 9106
  protocol  = "tcp"
  to_port   = 9106

  security_group_id = data.aws_security_group.prometheus_exporter_security_group.id
  type              = "ingress"

  source_security_group_id = data.aws_security_group.prometheus_cloudwatch_exporter_alb.id
}


resource "aws_security_group_rule" "prometheus_exporter_scrape_egress_to_prometheus" {
  description = "Allow egress to prometheus"

  from_port = 9106
  protocol  = "tcp"
  to_port   = 9106

  security_group_id = data.aws_security_group.prometheus_exporter_security_group.id
  type              = "egress"

  source_security_group_id = data.aws_security_group.prometheus_cloudwatch_exporter_alb.id
}


resource "aws_security_group_rule" "prometheus_scrape_egress_to_prometheus_exporter" {
  description = "Allow prometheus to scrape the cloudwatch exporter containers"

  from_port = 9106
  protocol  = "tcp"
  to_port   = 9106

  security_group_id = data.aws_security_group.prometheus_security_group.id
  type              = "egress"

  source_security_group_id = data.aws_security_group.prometheus_exporter_security_group.id
}

resource "aws_security_group_rule" "prometheus_scrape_egress_to_node_exporter" {
  description = "Allow prometheus to scrape the node exporters on the vpc"

  from_port = 9100
  protocol  = "tcp"
  to_port   = 9100
  type      = "egress"

  security_group_id = data.aws_security_group.prometheus_security_group.id
  cidr_blocks       = var.allowed_ingress_cidr
}

resource "aws_security_group_rule" "prometheus_scrape_egress_to_postfix_exporter" {
  description = "Allow prometheus to scrape the postfix exporters on the vpc"

  from_port = 9154
  protocol  = "tcp"
  to_port   = 9154
  type      = "egress"

  security_group_id = data.aws_security_group.prometheus_security_group.id
  cidr_blocks       = var.allowed_ingress_cidr
}

resource "aws_security_group_rule" "prometheus_alb_ingress_from_alb" {
  description = "Allow prometheus http port access from our alb"

  from_port = 9090
  protocol  = "tcp"
  to_port   = 9090

  security_group_id = data.aws_security_group.prometheus_security_group.id
  type              = "ingress"

  source_security_group_id = data.aws_security_group.prometheus_alb.id
}

resource "aws_security_group_rule" "prometheus_alb_egress_to_alb" {
  description = "Allow prometheus http port access to our alb"

  from_port = 9090
  protocol  = "tcp"
  to_port   = 9090

  security_group_id = data.aws_security_group.prometheus_security_group.id
  type              = "egress"

  source_security_group_id = data.aws_security_group.prometheus_alb.id
}

# tfsec:ignore:aws-vpc-no-public-egress-sgr
resource "aws_security_group_rule" "allow_all_prometheus_outbound" {
  description = "Allow all outbound traffic"

  from_port = 0
  protocol  = -1
  to_port   = 0

  security_group_id = data.aws_security_group.prometheus_security_group.id
  type              = "egress"

  cidr_blocks = ["0.0.0.0/0"] #tfsec:ignore:AWS007
}

resource "aws_security_group_rule" "allow_http_to_alb_from_vpc" {
  description = "Allow http access to alb from the vpc"

  from_port = 80
  protocol  = "tcp"
  to_port   = 80

  security_group_id = data.aws_security_group.prometheus_alb.id
  type              = "ingress"

  cidr_blocks = var.allowed_ingress_cidr
}

resource "aws_security_group_rule" "allow_prometheus_http_alb_ingress_to_prometheus" {
  description = "Allow access from prometheus containers to alb"

  from_port = 9090
  protocol  = "tcp"
  to_port   = 9090

  security_group_id = data.aws_security_group.prometheus_alb.id
  type              = "ingress"

  source_security_group_id = data.aws_security_group.prometheus_security_group.id
}

resource "aws_security_group_rule" "allow_prometheus_http_alb_egress_from_prometheus" {
  description = "Allow alb to connect to prometheus containers"

  from_port = 9090
  protocol  = "tcp"
  to_port   = 9090

  security_group_id = data.aws_security_group.prometheus_alb.id
  type              = "egress"

  source_security_group_id = data.aws_security_group.prometheus_security_group.id
}

resource "aws_security_group_rule" "prometheus_alb_allow_https_ingress_from_vpc" {
  description = "Allow https access to the alb"

  from_port = 443
  protocol  = "tcp"
  to_port   = 443

  security_group_id = data.aws_security_group.prometheus_alb.id
  type              = "ingress"

  cidr_blocks = var.allowed_ingress_cidr
}

resource "aws_security_group_rule" "prometheus_alb_allow_https_egress_to_vpc" {
  description = "Allow https access from the alb"

  from_port = 443
  protocol  = "tcp"
  to_port   = 443

  security_group_id = data.aws_security_group.prometheus_alb.id
  type              = "egress"

  cidr_blocks = var.allowed_ingress_cidr
}

resource "aws_security_group_rule" "prometheus_cloudwatch_exporter_ingress_to_alb_from_vpc" {
  description = "Allow http access to alb from the vpc"

  from_port         = 9106
  protocol          = "tcp"
  security_group_id = data.aws_security_group.prometheus_cloudwatch_exporter_alb.id
  to_port           = 9106
  type              = "ingress"

  cidr_blocks = var.allowed_ingress_cidr
}

resource "aws_security_group_rule" "prometheus_cloudwatch_exporter_ingress_from_alb" {
  description = "Allow access from prometheus containers to alb"

  from_port         = 9106
  protocol          = "tcp"
  security_group_id = data.aws_security_group.prometheus_cloudwatch_exporter_alb.id
  to_port           = 9106
  type              = "ingress"

  source_security_group_id = data.aws_security_group.prometheus_exporter_security_group.id
}

resource "aws_security_group_rule" "prometheus_cloudwatch_exporter_egress_to_alb" {
  description = "Allow alb to connect to prometheus containers"

  from_port         = 9106
  protocol          = "tcp"
  security_group_id = data.aws_security_group.prometheus_cloudwatch_exporter_alb.id
  to_port           = 9106
  type              = "egress"

  source_security_group_id = data.aws_security_group.prometheus_exporter_security_group.id
}

###EFS/NFS SG
resource "aws_security_group_rule" "nfs_ingress_tcp" {
  description              = "Allow NFS traffic into mount target from ECS"
  type                     = "ingress"
  from_port                = 2049
  to_port                  = 2049
  protocol                 = "tcp"
  security_group_id        = var.ecs_to_efs_sg_id
  source_security_group_id = data.aws_security_group.prometheus_security_group.id
}

resource "aws_security_group_rule" "nfs_egress_tcp" {
  description              = "Allow NFS traffic from mount target into ECS"
  type                     = "egress"
  from_port                = 2049
  to_port                  = 2049
  protocol                 = "tcp"
  security_group_id        = var.ecs_to_efs_sg_id
  source_security_group_id = data.aws_security_group.prometheus_security_group.id
}

resource "aws_security_group_rule" "prometheus_nfs_ingress_tcp" {
  description              = "Allow NFS into ECS from mount target"
  type                     = "ingress"
  from_port                = 2049
  to_port                  = 2049
  protocol                 = "tcp"
  security_group_id        = data.aws_security_group.prometheus_security_group.id
  source_security_group_id = var.ecs_to_efs_sg_id
}

resource "aws_security_group_rule" "prometheus_nfs_egress_tcp" {
  description              = "Allow NFS from ECS to mount target"
  type                     = "egress"
  from_port                = 2049
  to_port                  = 2049
  protocol                 = "tcp"
  security_group_id        = data.aws_security_group.prometheus_security_group.id
  source_security_group_id = var.ecs_to_efs_sg_id
}

resource "aws_security_group_rule" "nfs_ingress_udp" {
  description              = "Allow NFS traffic into mount target from ECS"
  type                     = "ingress"
  from_port                = 2049
  to_port                  = 2049
  protocol                 = "udp"
  security_group_id        = var.ecs_to_efs_sg_id
  source_security_group_id = data.aws_security_group.prometheus_security_group.id
}

resource "aws_security_group_rule" "nfs_egress_udp" {
  description              = "Allow NFS traffic from mount target into ECS"
  type                     = "egress"
  from_port                = 2049
  to_port                  = 2049
  protocol                 = "udp"
  security_group_id        = var.ecs_to_efs_sg_id
  source_security_group_id = data.aws_security_group.prometheus_security_group.id
}

resource "aws_security_group_rule" "prometheus_nfs_ingress_udp" {
  description              = "Allow NFS into ECS from mount target"
  type                     = "ingress"
  from_port                = 2049
  to_port                  = 2049
  protocol                 = "udp"
  security_group_id        = data.aws_security_group.prometheus_security_group.id
  source_security_group_id = var.ecs_to_efs_sg_id
}

resource "aws_security_group_rule" "prometheus_nfs_egress_udp" {
  description              = "Allow NFS from ECS to mount target"
  type                     = "egress"
  from_port                = 2049
  to_port                  = 2049
  protocol                 = "udp"
  security_group_id        = data.aws_security_group.prometheus_security_group.id
  source_security_group_id = var.ecs_to_efs_sg_id
}

resource "aws_security_group_rule" "nfs_secure_ingress_tcp" {
  description              = "Allow NFS traffic into mount target from ECS"
  type                     = "ingress"
  from_port                = 2149
  to_port                  = 2149
  protocol                 = "tcp"
  security_group_id        = var.ecs_to_efs_sg_id
  source_security_group_id = data.aws_security_group.prometheus_security_group.id
}

resource "aws_security_group_rule" "nfs_secure_egress_tcp" {
  description              = "Allow NFS traffic from mount target into ECS"
  type                     = "egress"
  from_port                = 2149
  to_port                  = 2149
  protocol                 = "tcp"
  security_group_id        = var.ecs_to_efs_sg_id
  source_security_group_id = data.aws_security_group.prometheus_security_group.id
}

resource "aws_security_group_rule" "prometheus_nfs_secure_ingress_tcp" {
  description              = "Allow NFS into ECS from mount target"
  type                     = "ingress"
  from_port                = 2149
  to_port                  = 2149
  protocol                 = "tcp"
  security_group_id        = data.aws_security_group.prometheus_security_group.id
  source_security_group_id = var.ecs_to_efs_sg_id
}

resource "aws_security_group_rule" "prometheus_nfs_secure_egress_tcp" {
  description              = "Allow NFS from ECS to mount target"
  type                     = "egress"
  from_port                = 2149
  to_port                  = 2149
  protocol                 = "tcp"
  security_group_id        = data.aws_security_group.prometheus_security_group.id
  source_security_group_id = var.ecs_to_efs_sg_id
}

### Grafana RDS required later
resource "aws_security_group_rule" "grafana_containers_to_db" {
  description = "All Grafana Containers to Postgres"

  from_port = 5432
  protocol  = "tcp"
  to_port   = 5432
  type      = "ingress"

  security_group_id        = data.aws_security_group.grafana_db_security_group.id
  source_security_group_id = data.aws_security_group.grafana_security_group.id
}

### Grafana Containers
# tfsec:ignore:aws-vpc-no-public-egress-sgr
resource "aws_security_group_rule" "grafana_to_world_https" {
  description = "All Grafana Containers HTTPS to world"

  from_port = 443
  protocol  = "tcp"
  to_port   = 443
  type      = "egress"

  security_group_id = data.aws_security_group.grafana_security_group.id
  cidr_blocks       = ["0.0.0.0/0"] #tfsec:ignore:AWS007
}

# Required later
resource "aws_security_group_rule" "grafana_to_postgres" {
  description = "All Grafana Containers to Postgres"

  from_port = 5432
  protocol  = "tcp"
  to_port   = 5432
  type      = "egress"

  security_group_id        = data.aws_security_group.grafana_security_group.id
  source_security_group_id = data.aws_security_group.grafana_db_security_group.id
}

resource "aws_security_group_rule" "grafana_ingress_from_alb" {
  description = "All Grafana Containers HTTPS from alb"

  from_port = 3000
  protocol  = "tcp"
  to_port   = 3000
  type      = "ingress"

  security_group_id        = data.aws_security_group.grafana_security_group.id
  source_security_group_id = data.aws_security_group.grafana_alb_security_group.id
}

### Grafana Alb
resource "aws_security_group_rule" "grafana_alb_to_vpc_https" {
  description = "Grafana ALB HTTPS to VPC"

  from_port = 443
  protocol  = "tcp"
  to_port   = 443
  type      = "egress"

  security_group_id = data.aws_security_group.grafana_alb_security_group.id
  cidr_blocks       = var.allowed_ingress_cidr
}

resource "aws_security_group_rule" "grafana_alb_to_grafana_container" {
  description = "Grafana ALB HTTPS to Containers"

  from_port = 3000
  protocol  = "tcp"
  to_port   = 3000
  type      = "egress"

  security_group_id        = data.aws_security_group.grafana_alb_security_group.id
  source_security_group_id = data.aws_security_group.grafana_security_group.id
}

resource "aws_security_group_rule" "vpc_to_grafana_alb_https" {
  description = "VPC HTTPS to Grafana ALB"

  from_port = 443
  protocol  = "tcp"
  to_port   = 443
  type      = "ingress"

  security_group_id = data.aws_security_group.grafana_alb_security_group.id
  cidr_blocks       = var.allowed_ingress_cidr
}

resource "aws_security_group_rule" "vpc_to_grafana_alb_http" {
  description = "VPC HTTP to Grafana ALB"

  from_port = 80
  protocol  = "tcp"
  to_port   = 80
  type      = "ingress"

  security_group_id = data.aws_security_group.grafana_alb_security_group.id
  cidr_blocks       = var.allowed_ingress_cidr
}

## Alert Manager

resource "aws_security_group_rule" "prometheus_alert_manager_alb_ingress_from_container" {
  description = "Allow prometheus http port access from our alb"

  from_port = 9092
  protocol  = "tcp"
  to_port   = 9092

  security_group_id = data.aws_security_group.prometheus_security_group.id
  type              = "ingress"

  source_security_group_id = data.aws_security_group.prometheus_alert_manager_alb.id
}

resource "aws_security_group_rule" "prometheus_alert_manager_alb_egress_to_container" {
  description = "Allow prometheus http port access to our alb"

  from_port = 9092
  protocol  = "tcp"
  to_port   = 9092

  security_group_id = data.aws_security_group.prometheus_security_group.id
  type              = "egress"

  source_security_group_id = data.aws_security_group.prometheus_alert_manager_alb.id
}

resource "aws_security_group_rule" "prometheus_alert_manager_alb_ingress_to_container" {
  description = "Allow prometheus http port access from our alb"

  from_port = 9092
  protocol  = "tcp"
  to_port   = 9092

  security_group_id = data.aws_security_group.prometheus_alert_manager_alb.id
  type              = "ingress"

  source_security_group_id = data.aws_security_group.prometheus_alert_manager_alb.id
}

resource "aws_security_group_rule" "prometheus_alert_manager_alb_egress_from_container" {
  description = "Allow prometheus http port access to our alb"

  from_port = 9092
  protocol  = "tcp"
  to_port   = 9092

  security_group_id = data.aws_security_group.prometheus_alert_manager_alb.id
  type              = "egress"

  source_security_group_id = data.aws_security_group.prometheus_security_group.id
}

resource "aws_security_group_rule" "allow_http_to_alert_manager_alb_from_vpc" {
  description = "Allow http access to alb from the vpc"

  from_port = 80
  protocol  = "tcp"
  to_port   = 80

  security_group_id = data.aws_security_group.prometheus_alert_manager_alb.id
  type              = "ingress"

  cidr_blocks = var.allowed_ingress_cidr
}

resource "aws_security_group_rule" "allow_https_to_alert_manager_alb_from_vpc" {
  description = "Allow https access to alb from the vpc"

  from_port = 443
  protocol  = "tcp"
  to_port   = 443

  security_group_id = data.aws_security_group.prometheus_alert_manager_alb.id
  type              = "ingress"

  cidr_blocks = var.allowed_ingress_cidr
}

resource "aws_security_group_rule" "prometheus_alert_manager_alb_allow_https_egress_to_vpc" {
  description = "Allow https access from the alb"

  from_port = 443
  protocol  = "tcp"
  to_port   = 443

  security_group_id = data.aws_security_group.prometheus_alert_manager_alb.id
  type              = "egress"

  cidr_blocks = var.allowed_ingress_cidr
}

resource "aws_security_group_rule" "allow_logstash_alb_ingress_to_logstash" {
  description = "Allow Logstash ingress from ALB"

  to_port   = 9600
  from_port = 9600

  protocol = "tcp"
  type     = "ingress"

  security_group_id        = data.aws_security_group.logstash_security_group.id
  source_security_group_id = data.aws_security_group.logstash_alb_security_group.id
}

# tfsec:ignore:aws-vpc-no-public-egress-sgr
resource "aws_security_group_rule" "allow_logstash_egress_to_world" {
  description = "Allow Logstash ingress from ALB"

  to_port   = 443
  from_port = 443

  protocol = "tcp"
  type     = "egress"

  security_group_id = data.aws_security_group.logstash_security_group.id
  cidr_blocks       = ["0.0.0.0/0"] #tfsec:ignore:AWS007
}

resource "aws_security_group_rule" "allow_elasticsearch_egress_from_logstash" {
  description = "Allow Logstash egress to elasticsearch"

  to_port   = 443
  from_port = 443

  protocol = "tcp"
  type     = "egress"

  security_group_id        = data.aws_security_group.logstash_security_group.id
  source_security_group_id = data.aws_security_group.elasticsearch_security_group.id
}

resource "aws_security_group_rule" "allow_elasticsearch_ingress_from_logstash" {
  description = "Allow elasticsearch ingress from logstash"

  to_port   = 443
  from_port = 443

  protocol = "tcp"
  type     = "ingress"

  source_security_group_id = data.aws_security_group.logstash_security_group.id
  security_group_id        = data.aws_security_group.elasticsearch_security_group.id
}

resource "aws_security_group_rule" "allow_logstash_alb_ingress_from_vpc" {
  description = "Allow Logstash ALB ingress from vpc"

  to_port   = 443
  from_port = 443

  protocol = "tcp"
  type     = "ingress"

  security_group_id = data.aws_security_group.logstash_alb_security_group.id
  cidr_blocks       = var.allowed_ingress_cidr
}

resource "aws_security_group_rule" "allow_logstash_alb_egress_to_logstash_container" {
  description = "Allow Logstash ALB egress to container"

  to_port   = 9600
  from_port = 9600

  protocol = "tcp"
  type     = "egress"

  security_group_id        = data.aws_security_group.logstash_alb_security_group.id
  source_security_group_id = data.aws_security_group.logstash_security_group.id
}

### Blackbox Exporter ALB
resource "aws_security_group_rule" "prometheus_scrape_ingress_to_prometheus_black_box_exporter_alb" {
  description = "Allow prometheus to access the bbe alb"

  from_port = 9116
  protocol  = "tcp"
  to_port   = 9116
  type      = "ingress"

  source_security_group_id = data.aws_security_group.prometheus_security_group.id
  security_group_id        = data.aws_security_group.prometheus_blackbox_exporter_alb.id
}

resource "aws_security_group_rule" "prometheus_scrape_egress_to_prometheus_black_box_exporter" {
  description = "Allow prometheus to access the bbe alb"

  from_port = 9116
  protocol  = "tcp"
  to_port   = 9116
  type      = "egress"

  security_group_id        = data.aws_security_group.prometheus_security_group.id
  source_security_group_id = data.aws_security_group.prometheus_blackbox_exporter_alb.id
}

### Blackbox Exporter
resource "aws_security_group_rule" "allow_ingress_to_black_box_exporter_from_alb" {
  description = "Allow BBE containers ingress from alb"

  from_port = 9116
  protocol  = "tcp"
  to_port   = 9116
  type      = "ingress"

  security_group_id        = data.aws_security_group.prometheus_blackbox_exporter_security_group.id
  source_security_group_id = data.aws_security_group.prometheus_blackbox_exporter_alb.id
}

resource "aws_security_group_rule" "allow_black_box_exporter_alb_egress" {
  description = "Allow BBE alb egress to containers"

  from_port = 9116
  protocol  = "tcp"
  to_port   = 9116
  type      = "egress"

  source_security_group_id = data.aws_security_group.prometheus_blackbox_exporter_security_group.id
  security_group_id        = data.aws_security_group.prometheus_blackbox_exporter_alb.id
}

# tfsec:ignore:aws-vpc-no-public-egress-sgr
resource "aws_security_group_rule" "allow_bbe_containers_https_egress" {
  description = "Allow BBE containers egress to world"

  from_port = 443
  protocol  = "tcp"
  to_port   = 443
  type      = "egress"

  security_group_id = data.aws_security_group.prometheus_blackbox_exporter_security_group.id
  cidr_blocks       = ["0.0.0.0/0"] #tfsec:ignore:AWS007
}

resource "aws_security_group_rule" "allow_bbe_containers_pnc_egress" {
  description = "Allow BBE containers PNC egress to the VPC"

  from_port = local.pnc_port
  protocol  = "tcp"
  to_port   = local.pnc_port
  type      = "egress"

  security_group_id = data.aws_security_group.prometheus_blackbox_exporter_security_group.id
  cidr_blocks       = var.allowed_ingress_cidr
}

resource "aws_security_group_rule" "allow_user_service_bbe_ingress" {
  description = "Allow BBE containers Ingress into the User Service ALB"

  from_port = 443
  to_port   = 443
  protocol  = "tcp"
  type      = "ingress"

  security_group_id        = data.aws_security_group.user_service_alb.id
  source_security_group_id = data.aws_security_group.prometheus_blackbox_exporter_security_group.id
}

resource "aws_security_group_rule" "allow_bbe_egress_to_user_service" {
  description = "Allow BBE containers Ingress into the User Service ALB"

  from_port = 443
  to_port   = 443
  protocol  = "tcp"
  type      = "egress"

  security_group_id        = data.aws_security_group.prometheus_blackbox_exporter_security_group.id
  source_security_group_id = data.aws_security_group.user_service_alb.id
}

resource "aws_security_group_rule" "allow_bichard7_bbe_ingress" {
  description = "Allow BBE containers Ingress into the Bichard7 ALB"

  from_port = 443
  to_port   = 443
  protocol  = "tcp"
  type      = "ingress"

  security_group_id        = data.aws_security_group.bichard_alb_web.id
  source_security_group_id = data.aws_security_group.prometheus_blackbox_exporter_security_group.id
}

resource "aws_security_group_rule" "allow_bbe_egress_to_bichard7" {
  description = "Allow BBE containers Ingress into the Bichard7 ALB"

  from_port = 443
  to_port   = 443
  protocol  = "tcp"
  type      = "egress"

  security_group_id        = data.aws_security_group.prometheus_blackbox_exporter_security_group.id
  source_security_group_id = data.aws_security_group.bichard_alb_web.id
}

resource "aws_security_group_rule" "allow_bichard7_backend_bbe_ingress" {
  description = "Allow BBE containers Ingress into the Bichard7 backend ALB"

  from_port = 443
  to_port   = 443
  protocol  = "tcp"
  type      = "ingress"

  security_group_id        = data.aws_security_group.bichard7_alb_backend.id
  source_security_group_id = data.aws_security_group.prometheus_blackbox_exporter_security_group.id
}

resource "aws_security_group_rule" "allow_bbe_egress_to_bichard7_backend" {
  description = "Allow BBE containers Ingress into the Bichard7 Backend ALB"

  from_port = 443
  to_port   = 443
  protocol  = "tcp"
  type      = "egress"

  security_group_id        = data.aws_security_group.prometheus_blackbox_exporter_security_group.id
  source_security_group_id = data.aws_security_group.bichard7_alb_backend.id
}

resource "aws_security_group_rule" "allow_audit_logging_bbe_ingress" {
  description = "Allow BBE containers Ingress into the Audit Logging ALB"

  from_port = 443
  to_port   = 443
  protocol  = "tcp"
  type      = "ingress"

  security_group_id        = data.aws_security_group.audit_logging_portal_alb.id
  source_security_group_id = data.aws_security_group.prometheus_blackbox_exporter_security_group.id
}

resource "aws_security_group_rule" "allow_bbe_egress_to_audit_logging" {
  description = "Allow BBE containers Ingress into the Audit Logging ALB"

  from_port = 443
  to_port   = 443
  protocol  = "tcp"
  type      = "egress"

  security_group_id        = data.aws_security_group.prometheus_blackbox_exporter_security_group.id
  source_security_group_id = data.aws_security_group.audit_logging_portal_alb.id
}

resource "aws_security_group_rule" "allow_bbe_containers_https_to_vpc" {
  description = "Allow BBE containers HTTPS to VPC"

  from_port = 443
  protocol  = "tcp"
  to_port   = 443
  type      = "egress"

  security_group_id = data.aws_security_group.prometheus_blackbox_exporter_security_group.id
  cidr_blocks       = var.allowed_ingress_cidr
}
