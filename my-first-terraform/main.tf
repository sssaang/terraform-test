provider "aws" {
  region = "ap-northeast-2"
}

resource "aws_instance" "test" {
  ami = "ami-0ba5cd124d7a79612"
  instance_type = "t2.micro"
  vpc_security_group_ids = [aws_security_group.instance.id]

  user_data = <<-EOF
                #!/bin/bash
                echo "Hello World!" > index.html
                nohup busybox httpd -f -p ${var.server_port} &
                EOF

  tags = {
    Name = "ec2 terraform"
  }
}

resource "aws_security_group" "instance"{
  name = "terraform-example-instance"

  ingress {
  from_port = var.server_port
  to_port = var.server_port
  protocol = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
  }
}

variable "server_port" {
  description = "The port the server will use for HTTP requests"
  type = number
  default = 8080
}