resource "aws_vpc" "this" {
  cidr_block = "10.20.20.0/26"
  enable_dns_support = true 
  enable_dns_hostnames = true 
  tags = {
    "Name" = "My custom vpc"
  }
}

resource "aws_subnet" "private" {
    ##3this length determine the lenght of a given list map or string
    ##3it is like an array 
  count = length(var.subnet_cidr_private)
  vpc_id = aws_vpc.this.id 
  ##3to create this subnet one by one i use count.index. it start with 0
  ##3it will count all the cidr block once it count the num,ber of cidr block it will use the count index
  #$#and crate all the cidr one by one as per the az
  cidr_block = var.subnet_cidr_private[count.index]
  availability_zone = var.availability_zone[count.index]
  tags = {
    "Name" = "My custom vpc subnet"
  }
}
##3this block will create an custom rtb
resource "aws_route_table" "this-rtb" {
  vpc_id = aws_vpc.this .id 
  tags = {
    "name" = "internet gw for my custom vpc"
  }
}

resource "aws_route_table_association" "private" {
  ##3this will attache all my subnet with internet gw in my vpc
  count = length(var.subnet_cidr_private)
  subnet_id = element(aws_subnet.private.*.id,count.index)
  route_table_id = aws_route_table.this-rtb.id 
}

resource "aws_internet_gateway" "this-igw" {
  vpc_id = aws_vpc.this .id 
}

resource "aws_route" "internet_route" {
  destination_cidr_block = "0.0.0.0/0"
  route_table_id = aws_route_table.this-rtb.id 
  gateway_id = aws_internet_gateway.this-igw.id
}