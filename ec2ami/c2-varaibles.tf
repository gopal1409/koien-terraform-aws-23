variable "aws_region" {
  description = "Region in which aws resource to be created"
  type = string #map list
  default = "us-east-1"
}

variable "instance_type" {
  description = "ec2 instance type"
  type = string
  default = "t3.micro"
}

variable "instance_keypair" {
  type = string 
  default = "terraform-key"
}