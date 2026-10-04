resource "aws_iam_role" "ec2_session_manager_remote_host_port_forwarding" {
  name = format("%s-iam-role", var.project_name_session_manager)

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      },
    ]
  })

  tags = {
    Name        = format("%s-iam-role", var.project_name_session_manager)
    Environment = var.environment
    Terraform   = "True"
  }
}

resource "aws_iam_role_policy_attachment" "ec2_session_manager_remote_host_port_forwarding" {
  role       = aws_iam_role.ec2_session_manager_remote_host_port_forwarding.name
  policy_arn = var.ssm_policy_arn
}

resource "aws_iam_instance_profile" "ec2_session_manager_remote_host_port_forwarding" {
  name = format("%s-iam-instance-profile", var.project_name_session_manager)
  role = aws_iam_role.ec2_session_manager_remote_host_port_forwarding.name
  tags = {
    Name        = format("%s-iam-instance-role", var.project_name_session_manager)
    Environment = var.environment
    Terraform   = "True"
  }
}