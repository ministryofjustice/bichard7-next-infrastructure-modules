resource "aws_security_group_rule" "db_egress_to_was_web" {
  description = "Allow database to egress to application frontend containers"

  from_port = 5432
  to_port   = 5432
  protocol  = "tcp"
  type      = "egress"

  security_group_id        = data.aws_security_group.db.id
  source_security_group_id = data.aws_security_group.bichard7_web.id
}

resource "aws_security_group_rule" "db_egress_to_was_backend" {
  description = "Allow database to application backend containers"

  from_port = 5432
  to_port   = 5432
  protocol  = "tcp"
  type      = "egress"

  security_group_id        = data.aws_security_group.db.id
  source_security_group_id = data.aws_security_group.bichard7_backend.id
}

resource "aws_security_group_rule" "was_web_ingress_to_db" {
  description = "Allow database access from application frontend containers"

  from_port = 5432
  to_port   = 5432
  protocol  = "tcp"
  type      = "ingress"

  security_group_id        = data.aws_security_group.db.id
  source_security_group_id = data.aws_security_group.bichard7_web.id
}

resource "aws_security_group_rule" "was_backend_ingress_to_db" {
  description = "Allow database access from application backend containers"

  from_port = 5432
  to_port   = 5432
  protocol  = "tcp"
  type      = "ingress"

  security_group_id        = data.aws_security_group.db.id
  source_security_group_id = data.aws_security_group.bichard7_backend.id
}

resource "aws_security_group_rule" "db_egress_to_user_service_ecs" {
  description = "Allow database access to to user service"

  from_port = 5432
  to_port   = 5432
  protocol  = "tcp"
  type      = "egress"

  security_group_id        = data.aws_security_group.db.id
  source_security_group_id = data.aws_security_group.user_service_ecs.id
}

resource "aws_security_group_rule" "user_service_ecs_ingress_to_db" {
  description = "Allow user service to database"

  from_port = 5432
  to_port   = 5432
  protocol  = "tcp"
  type      = "ingress"

  security_group_id        = data.aws_security_group.db.id
  source_security_group_id = data.aws_security_group.user_service_ecs.id
}

resource "aws_security_group_rule" "ui_ecs_ingress_to_db" {
  description = "Allow ui to database"

  from_port = 5432
  to_port   = 5432
  protocol  = "tcp"
  type      = "ingress"

  security_group_id        = data.aws_security_group.db.id
  source_security_group_id = data.aws_security_group.ui_ecs.id
}
