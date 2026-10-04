resource "aws_db_subnet_group" "postgresql" {
  name = format("%s-db-subnets", var.project_name_session_manager)
  subnet_ids = [
    data.aws_ssm_parameter.private_subnet_1a.value,
    data.aws_ssm_parameter.private_subnet_1b.value,
  ]

  tags = {
    Name        = format("%s-db-subnets", var.project_name_session_manager)
    Environment = var.environment
    Terraform   = "True"
  }
}

resource "aws_security_group" "rds" {
  name        = format("%s-rds-sg", var.project_name_session_manager)
  description = "PostgreSQL acessivel somente pela EC2 do Session Manager"
  vpc_id      = data.aws_ssm_parameter.vpc.value

  tags = {
    Name        = format("%s-rds-sg", var.project_name_session_manager)
    Environment = var.environment
    Terraform   = "True"
  }
}

resource "aws_vpc_security_group_ingress_rule" "rds_from_ec2" {
  security_group_id            = aws_security_group.rds.id
  referenced_security_group_id = aws_security_group.ec2_session_manager_remote_host_port_forwarding.id
  ip_protocol                  = "tcp"
  from_port                    = 5432
  to_port                      = 5432
}

resource "aws_vpc_security_group_egress_rule" "ec2_to_rds" {
  security_group_id            = aws_security_group.ec2_session_manager_remote_host_port_forwarding.id
  referenced_security_group_id = aws_security_group.rds.id
  ip_protocol                  = "tcp"
  from_port                    = 5432
  to_port                      = 5432
}

resource "aws_db_instance" "postgresql" {
  identifier                  = format("%s-postgresql", var.project_name_session_manager)
  engine                      = "postgres"
  instance_class              = var.db_instance_class
  allocated_storage           = 20
  storage_type                = "gp3"
  db_name                     = var.db_name
  username                    = var.db_username
  manage_master_user_password = true
  db_subnet_group_name        = aws_db_subnet_group.postgresql.name
  vpc_security_group_ids      = [aws_security_group.rds.id]
  publicly_accessible         = false
  skip_final_snapshot         = true

  tags = {
    Name        = format("%s-postgresql", var.project_name_session_manager)
    Environment = var.environment
    Terraform   = "True"
  }
}
