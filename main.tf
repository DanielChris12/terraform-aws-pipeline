provider "aws" {
  region = "us-east-2"
}

# Security Group for EC2 and RDS
resource "aws_security_group" "my_security_group1" {
  name        = "my-security-group1"
  description = "Allow SSH, HTTP, HTTPS, 8080 for Jenkins & Maven"
  vpc_id      = "vpc-0357649d6cbeee415"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# EC2 Instance
resource "aws_instance" "my_ec2_instance1" {
  ami                    = "ami-04f167a56786e4b09"
  instance_type          = "t2.medium"
  vpc_security_group_ids = [aws_security_group.my_security_group1.id]
  key_name               = "dan"

  root_block_device {
    volume_size = 30
    volume_type = "gp2"
  }

  tags = {
    Name = "jenkins-server"
  }
}

# S3 Bucket
resource "aws_s3_bucket" "my_s3_bucket" {
  bucket = "my-terraform-s3-bucket-1245"
}

# RDS Database
resource "aws_db_instance" "my_rds" {
  allocated_storage      = 20
  engine                 = "postgres"
  engine_version         = "14"
  instance_class         = "db.t3.micro"
  db_name                = "mydatabase"
  username               = "dbadmin"
  password               = "securepassword123"
  parameter_group_name   = "default.postgres14"
  publicly_accessible    = true
  vpc_security_group_ids = [aws_security_group.my_security_group1.id]
  skip_final_snapshot    = true
}
