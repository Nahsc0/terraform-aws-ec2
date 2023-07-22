
resource "aws_instance" "instance" {
  ami                         = "ami-053b0d53c279acc90"
  instance_type               = "t2.micro"
  vpc_security_group_ids      = [aws_security_group.instance.id]
  key_name                    = "nasco"
  user_data                   = <<-EOF
    #!/bin/bash
    sudo apt install nginx
    sudo systemctl start nginx
    sudo systemctl enable nginx
  EOF
  user_data_replace_on_change = true
  tags = {
    Name = "terraform-instance"
  }
}

provider "aws" {
  region = "us-east-1" # Replace with your desired region
}

data "http" "my_ip" {
  url = "https://checkip.amazonaws.com/"
}

resource "aws_security_group" "instance" {
  name_prefix = "instance-security-group"

  # Allow inbound SSH (TCP port 22) from your public IP address
  ingress {
    description = "SSH access"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Allow inbound HTTP (TCP port 80) from anywhere
  ingress {
    description = "HTTP access"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Allow inbound HTTPS (TCP port 443) from anywhere
  ingress {
    description = "HTTPS access"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Allow all outbound traffic
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
