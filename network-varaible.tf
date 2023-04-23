variable "aws_az" {
  type = string 
  default = "us-east-1a"
}

variable "vpc_cidr" {
  type = string 
  default = "10.1.64.0/18"
}

variable "public_subnet_cidr" {
  type = string
  default = "10.1.64.0/24"
}