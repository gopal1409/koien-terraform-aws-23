###i want to create a resource called as instance
resource "aws_instance" "web" {
  ami           = "ami-005f9685cb30f234b"
  instance_type = "t3.micro"
  ###too look for user data in current directoru al;ways puth path.module
  user_data = file("${path.module}/app1-install.sh")
  tags = {
    Name = "Ec2 demo"
  }
}