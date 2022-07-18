resource "aws_db_instance" "MySQL" {
  allocated_storage    = 12
  engine               = "mysql"
  storage_type         = "gp2"
  engine_version       = "5.7"
  instance_class       = "db.t3.micro"
  identifier           = "mysqldatabase"
  username             = var.username
  password             = var.password
  publicly_accessible  = false
  db_subnet_group_name = aws_db_subnet_group.sql-group.name
  skip_final_snapshot  = true
  parameter_group_name = "default.mysql5.7"

}


#DB subnet group name
resource "aws_db_subnet_group" "sql-group" {
  name       = "mysubgrp"
  subnet_ids = [aws_subnet.pri-sub-1.id, aws_subnet.pri-sub-2.id]

  tags = {
    Name = "my sql grp"
  }
}


#DB security group
resource "aws_security_group" "mysql_secgrp" {
  name        = "mysql-secgroup"
  description = "Allow TLS inbound traffic"
  vpc_id      = aws_vpc.project1.id

  ingress {
    description = "TLS from MySQL"
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }


  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "allow_tls"
  }
}