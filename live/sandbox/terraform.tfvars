region                       = "us-east-1"
environment                  = "sandbox"
project_name_session_manager = "sessionmanager-remote-host-port-forwarding"

ssm_policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
instance_type  = "t4g.micro"

db_name           = "appdb"
db_username       = "dbadmin"
db_instance_class = "db.t3.micro"
