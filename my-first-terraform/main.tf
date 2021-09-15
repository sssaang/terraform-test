provider "aws" {
  region = "ap-northeast-2"
}

resource "aws_instance" "test" {
  ami = "ami-08c64544f5cfcddd0"
  instance_type = "t2.micro"

  user_data = <<-EOF
                #!/bin/bash
                echo "Hello World!" > index.html
                nohup busybox httpd -f -p 8080 &
                EOF

  tags = {
    Name = "ec2 terraform"
  }
}