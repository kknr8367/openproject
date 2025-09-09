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
              sudo dnf update -y
              sudo dnf install -y docker
              sudo systemctl enable docker
              sudo systemctl start docker
              sudo usermod -aG docker ec2-user
              newgrp docker
              sudo mkdir -p /var/lib/openproject/{pgdata,assets}
              sudo docker run -d \
                --name openproject \
                -p 8080:80 \
                -e OPENPROJECT_HOST_NAME=$(curl -s http://169.254.169.254/latest/meta-data/public-ipv4) \
                -e OPENPROJECT_SECRET_KEY_BASE=$(openssl rand -hex 32) \
                -e OPENPROJECT_HTTPS=false \
                -v /var/lib/openproject/pgdata:/var/openproject/pgdata \
                -v /var/lib/openproject/assets:/var/openproject/assets \
                openproject/openproject:16
              EOF


  tags = {
    Name = "OpenProject-EC2"
  }
}
