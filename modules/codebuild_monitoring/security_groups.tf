resource "aws_security_group" "grafana_db_security_group" {
  vpc_id      = var.vpc_id
  name        = "${var.name}-codebuild-grafana-db-sg"
  description = "Allow ingress/egress to the grafana db"

  tags = merge(
    var.tags,
    {
      Name = "${var.name}-codebuild-grafana-db-sg"
    }
  )
}

resource "aws_security_group" "grafana_cluster_security_group" {
  vpc_id      = var.vpc_id
  name        = "${var.name}-codebuild-grafana-cluster-sg"
  description = "Allow ingress/egress to the grafana cluster"

  tags = merge(
    var.tags,
    {
      Name = "${var.name}-codebuild-grafana-cluster-sg"
    }
  )
}
