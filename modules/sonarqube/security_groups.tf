### Sonar Container Rules
resource "aws_security_group" "sonar_security_group" {
  description = "Security Group for sonarqube container"

  name   = "${var.name}-container"
  vpc_id = module.vpc.vpc_id

  tags = merge(var.tags, { Name = "${var.name}-container" })
}

resource "aws_security_group_rule" "allow_all_github_ssl" {
  description = "Allow outbound github ssl traffic"

  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  security_group_id = aws_security_group.sonar_security_group.id
  type              = "egress"

  cidr_blocks = local.github_web_cidrs
}

resource "aws_security_group_rule" "allow_all_github_ssh" {
  description = "Allow outbound github ssh traffic"

  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  security_group_id = aws_security_group.sonar_security_group.id
  type              = "egress"

  cidr_blocks = local.github_git_cidrs
}

resource "aws_security_group_rule" "allow_all_github_http" {
  description = "Allow outbound github http traffic"

  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  security_group_id = aws_security_group.sonar_security_group.id
  type              = "egress"

  cidr_blocks = local.github_web_cidrs
}

resource "aws_security_group_rule" "allow_all_github_git" {
  description = "Allow outbound github git traffic"

  from_port         = 9418
  to_port           = 9418
  protocol          = "tcp"
  security_group_id = aws_security_group.sonar_security_group.id
  type              = "egress"

  cidr_blocks = local.github_git_cidrs
}

resource "aws_security_group_rule" "sonar_to_postgres_egress" {
  description = "Allow outbound postgres traffic"

  from_port         = 5432
  to_port           = 5432
  protocol          = "tcp"
  security_group_id = aws_security_group.sonar_security_group.id
  type              = "egress"

  source_security_group_id = module.vpc.default_security_group_id
}

resource "aws_security_group_rule" "sonar_egress" {
  description = "Allow outbound ALB traffic"

  from_port         = 9000
  to_port           = 9000
  protocol          = "tcp"
  security_group_id = aws_security_group.sonar_security_group.id
  type              = "egress"

  source_security_group_id = aws_security_group.sonar_alb.id
}

resource "aws_security_group_rule" "sonar_ingress" {
  description = "Allow inbound ALB traffic"

  from_port         = 9000
  to_port           = 9000
  protocol          = "tcp"
  security_group_id = aws_security_group.sonar_security_group.id
  type              = "ingress"

  source_security_group_id = aws_security_group.sonar_alb.id
}

# Security group for our sonar alb
resource "aws_security_group" "sonar_alb" {
  description = "${var.name} ALB Security Group"

  name   = "${var.name}-alb"
  vpc_id = module.vpc.vpc_id

  tags = merge(var.tags, { Name = "${var.name}-alb" })

  lifecycle {
    ignore_changes = [description]
  }
}

resource "aws_security_group_rule" "allow_http_ingress" {
  description = "Allow http inbound to ALB"

  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  security_group_id = aws_security_group.sonar_alb.id
  type              = "ingress"

  cidr_blocks = ["0.0.0.0/0"] #tfsec:ignore:AWS006
}

resource "aws_security_group_rule" "allow_http_egress" {
  description = "Allow http outbound from ALB"

  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  security_group_id = aws_security_group.sonar_alb.id
  type              = "egress"

  cidr_blocks = ["0.0.0.0/0"] #tfsec:ignore:AWS007
}

resource "aws_security_group_rule" "allow_https_ingress" {
  description = "Allow https inbound to ALB"

  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  security_group_id = aws_security_group.sonar_alb.id
  type              = "ingress"

  cidr_blocks = ["0.0.0.0/0"] #tfsec:ignore:AWS006
}

resource "aws_security_group_rule" "allow_https_egress" {
  description = "Allow https outbound from ALB"

  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  security_group_id = aws_security_group.sonar_alb.id
  type              = "egress"

  cidr_blocks = ["0.0.0.0/0"] #tfsec:ignore:AWS007
}

resource "aws_security_group_rule" "allow_alb_to_container" {
  description = "Allow the ALB to talk to the sonarqube container"

  from_port         = 9000
  to_port           = 9000
  protocol          = "tcp"
  security_group_id = aws_security_group.sonar_alb.id
  type              = "egress"

  source_security_group_id = aws_security_group.sonar_security_group.id
}


### Default VPC Allow Sonar to DB
resource "aws_security_group_rule" "postgres_db_ingress" {
  description = "Allow postgres and sonar to communicate"

  from_port         = 5432
  to_port           = 5432
  protocol          = "TCP"
  security_group_id = module.vpc.default_security_group_id
  type              = "ingress"

  source_security_group_id = aws_security_group.sonar_security_group.id
}

resource "aws_security_group_rule" "postgres_db_egress" {
  description = "Allow postgres and sonar to communicate"

  from_port         = 5432
  to_port           = 5432
  protocol          = "TCP"
  security_group_id = module.vpc.default_security_group_id
  type              = "egress"

  source_security_group_id = aws_security_group.sonar_security_group.id
}
