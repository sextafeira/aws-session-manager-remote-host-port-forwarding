resource "aws_instance" "ec2_session_manager_remote_host_port_forwarding" {
  associate_public_ip_address = false
  ami                         = data.aws_ssm_parameter.amazon_linux.value
  instance_type               = var.instance_type
  subnet_id                   = data.aws_ssm_parameter.private_subnet_1a.value
  vpc_security_group_ids      = [aws_security_group.ec2_session_manager_remote_host_port_forwarding.id]
  iam_instance_profile        = aws_iam_instance_profile.ec2_session_manager_remote_host_port_forwarding.id

  depends_on = [aws_iam_role_policy_attachment.ec2_session_manager_remote_host_port_forwarding]

  user_data = <<-EOF
    #!/bin/bash
    systemctl enable --now amazon-ssm-agent
    
  EOF

  metadata_options {
    http_tokens = "required"
  }

  root_block_device {
    encrypted   = true
    volume_type = "gp3"
  }

  tags = {
    Name        = format("%s-ec2-instance", var.project_name_session_manager)
    Environment = var.environment
    Terraform   = "True"
  }
}
