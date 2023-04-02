output "instance_app_public_dns" {
  description = "all the instance public dns"
  value = aws_instance.app-server.*.public_dns
}

output "load_balancer_dn_name" {
  description = "this will be my load balancer dns name"
  value = aws_lb.front.dns_name
}