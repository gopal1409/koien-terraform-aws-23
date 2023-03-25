output "instance_public_ip" {
  description = "Ec2 Instance Puiblic IP"
  value = aws_instance.myec2vm.public_ip
}

output "instance_public_dns" {
  description = "Ec2 instance public dns"
  value = aws_instance.myec2vm.public_dns
}