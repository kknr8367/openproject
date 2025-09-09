terraform {
  required_version = ">= 1.0.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 4.0"
    }
  }
}

resource "aws_instance" "openproject" {
  ami           = var.ami_id
  instance_type = var.instance_type
  subnet_id     = var.subnet_id
  security_groups = [var.security_group_id]

  user_data = <<-EOF
              #!/bin/bash
              sudo apt update -y
              sudo apt install docker.io -y
              #!/bin/bash

# Update all installed packages on the instance
              sudo yum update -y

# Install Docker
              sudo yum install docker -y

              sudo systemctl start docker
              sudo systemctl enable docker
              sudo usermod -aG docker ec2-user
              sudo systemctl start docker
              sudo systemctl enable docker
              sudo docker run -d -p 8080:80 openproject/community:latest
              EOF

  tags = {
    Name = "OpenProject-EC2"
  }
}
