resource "aws_security_group" "allow_http" {
  name        = "allow_http"
  description = "Allow http inbound traffic"
  vpc_id      = aws_vpc.this.id

  ingress {
    description      = "allow http from VPC"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
   
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "allow_http"
  }
}
data "aws_ami" "amazon_ami" {
  
  most_recent      = true
  
  owners           = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-gp2"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
  filter {
    name   = "architecture"
    values = ["x86_64"]
  }
}

resource "aws_instance" "app-server" {
##this is going to launch three instance in three different az 
  count = length(var.subnet_cidr_private)
  instance_type = "t2.micro"
  ami = data.aws_ami.amazon_ami.id 
  vpc_security_group_ids = [aws_security_group.allow_http.id]
  subnet_id = element(aws_subnet.private.*.id,count.index)
  associate_public_ip_address = true 
  user_data = file("user_data/user_data.tpl")
}