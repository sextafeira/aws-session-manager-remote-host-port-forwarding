output "instance_id" {
  value = aws_instance.ec2_session_manager_remote_host_port_forwarding.id
}

output "rds_address" {
  value = aws_db_instance.postgresql.address
}

output "db_name" {
  value = aws_db_instance.postgresql.db_name
}

output "db_username" {
  value = aws_db_instance.postgresql.username
}

output "db_master_secret_arn" {
  description = "ARN do segredo gerenciado pelo RDS; nao contem a senha."
  value       = aws_db_instance.postgresql.master_user_secret[0].secret_arn
}

output "start_session_command" {
  description = "Execute com AWS_PROFILE configurado; mantenha o terminal aberto."
  value = format(
    "aws ssm start-session --region %s --target %s --document-name AWS-StartPortForwardingSessionToRemoteHost --parameters '%s'",
    var.region,
    aws_instance.ec2_session_manager_remote_host_port_forwarding.id,
    jsonencode({
      host            = [aws_db_instance.postgresql.address]
      portNumber      = ["5432"]
      localPortNumber = ["5432"]
    })
  )
}
