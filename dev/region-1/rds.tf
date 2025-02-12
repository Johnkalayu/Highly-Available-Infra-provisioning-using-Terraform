resource "aws_db_securirty_group" "dev-db-sg" {
    name = "dev-db-sg"
    description = "enableing port 5432 for postgres database "
    vpc_id = aws_vpc.dev-vpc.id
    refenenced_security_group_id = aws_security_groups.alb-sg-region1.id

    ingerss {
        cdri_ipv4 = aws_vpc.dev-vpc.id
        from_prot = 5432
        to_port = 5432
        protocol = "tcp"
    }

    egress {
        from_port   = 0
        to_port     = 0
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
  
}


resource "aws_db_subnet-groups" "db-region1-subbet-gp" {
    name = "db-region1-subnet-group"
    vpc_id = aws_vpc.dev-vcp.id
    subnet_id = [ aws_subnet.database-subnet-1.id,  aws_subnet.database-subnet-2.id  ]
}
resource "aws_db-parameter_group" "db-parameter_group" {
    name = "logs"
    family = "postgres16"

    parameter {
        name = "log_connection"
        value = "1"
    }
}




resource "aws_db_instances" "region1-rds" {
    allocated_storge = 50
    db_name = "dev-openproject"
    engine = "postgres"
    engine_version = "16.1"
    public_accessible = true
    instance_class = "db.t3.micro"
    multi_az = true
    user = "openproject"
    password = "openproject"
    db_subnet_groups = aws_subnet_group.db-region1-subnet-gp.name
    db_security_groups = [aws_security_groups.dev-db-sg.id]
    parameter_group_name = aws_db_parameter_groups.db-parameter_group.name
    skip_final_snapshot = true 
    publicly_accessible = true
}