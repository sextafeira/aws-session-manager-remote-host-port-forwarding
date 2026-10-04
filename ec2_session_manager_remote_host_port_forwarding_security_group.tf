resource "aws_security_group" "ec2_session_manager_remote_host_port_forwarding" {
  name   = format("%s-security-group", var.project_name_session_manager)
  vpc_id = data.aws_ssm_parameter.vpc.value

  tags = {
    Name        = format("%s-sg", var.project_name_session_manager)
    Environment = var.environment
    Terraform   = "True"
  }
}

resource "aws_vpc_security_group_egress_rule" "ec2_session_manager_remote_host_port_forwarding_security_group_https" {
  security_group_id = aws_security_group.ec2_session_manager_remote_host_port_forwarding.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 443
  ip_protocol       = "tcp"
  to_port           = 443
}

