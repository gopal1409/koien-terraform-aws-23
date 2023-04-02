output "instance_app_public_dns" {
  description = "all the instance public dns"
  value = aws_instance.app-server.*.public_dns
}