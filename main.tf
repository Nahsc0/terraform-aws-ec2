# resource "aws_instance" "example" {
#   ami                    = "ami-053b0d53c279acc90"
#   instance_type          = "t2.micro"
#   user_data              = <<-EOF
#     #!/bin/bash
#     echo "Hello, World" > index.html
#     nohup busybox httpd -f -p 8000 &
#   EOF
#   user_data_replace_on_change = true
#   tags = {
#     Name = "terraform-example"
#   }
# }
resource "aws_security_group" "instance" {
  name = "terraform-example-instance"

  ingress {
    from_port   = 8000
    to_port     = 8000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
resource "aws_instance" "example" {
  ami                          = "ami-053b0d53c279acc90"
  instance_type                = "t2.micro"
  vpc_security_group_ids       = [aws_security_group.instance.id]
  user_data                    = <<-EOF
    #!/bin/bash
    echo "Hello, World" > index.html
    nohup busybox httpd -f -p 8000 &
  EOF
  user_data_replace_on_change  = true
  tags = {
    Name = "terraform-example"
  }
}


