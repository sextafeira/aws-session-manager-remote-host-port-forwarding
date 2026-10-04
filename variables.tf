variable "project_name_session_manager" {
  description = "Prefixo dos recursos deste projeto."
  type        = string
}

variable "region" {
  type = string
}

variable "environment" {
  type = string
}

variable "ssm_policy_arn" {
  type    = string
  default = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

variable "instance_type" {
  description = "Tipo EC2 compativel com a AMI ARM64."
  type        = string
  default     = "t4g.micro"
}

variable "private_subnet_1a_parameter_name" {
  description = "Parametro SSM da subnet privada 1a utilizada pela EC2 e pelo RDS."
  type        = string
  default     = "/private_subnet_1a_id"
}

variable "db_name" {
  type    = string
  default = "appdb"
}

variable "db_username" {
  type    = string
  default = "dbadmin"
}

variable "db_instance_class" {
  type    = string
  default = "db.t3.micro"
}
