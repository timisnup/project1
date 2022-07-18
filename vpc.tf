#VPC
resource "aws_vpc" "project1" {
  cidr_block           = var.vpc_cidr
  instance_tenancy     = "default"
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = "project1"
  }
}


#Public subnet 1
resource "aws_subnet" "pub-sub-1" {
  vpc_id            = aws_vpc.project1.id
  cidr_block        = var.pub_sub_1
  availability_zone = "eu-west-2a"

  tags = {
    Name = "pub-sub-1"
  }
}


#Public subnet 2
resource "aws_subnet" "pub-sub-2" {
  vpc_id            = aws_vpc.project1.id
  cidr_block        = var.pub_sub_2
  availability_zone = "eu-west-2b"

  tags = {
    Name = "pub-sub-2"
  }
}


#Private subnet 1
resource "aws_subnet" "pri-sub-1" {
  vpc_id            = aws_vpc.project1.id
  cidr_block        = var.pri_sub_1
  availability_zone = "eu-west-2a"

  tags = {
    Name = "pri-sub-1"
  }
}


#Private subnet 2
resource "aws_subnet" "pri-sub-2" {
  vpc_id            = aws_vpc.project1.id
  cidr_block        = var.pri_sub_2
  availability_zone = "eu-west-2b"

  tags = {
    Name = "pri-sub-2"
  }
}


#Public route table
resource "aws_route_table" "pub-rt" {
  vpc_id = aws_vpc.project1.id

  tags = {
    Name = "pub-rt"
  }
}


#Private route table
resource "aws_route_table" "pri-rt" {
  vpc_id = aws_vpc.project1.id

  tags = {
    Name = "pri-rt"
  }
}


#Public route table association
resource "aws_route_table_association" "pub-rt-1-association" {
  subnet_id      = aws_subnet.pub-sub-1.id
  route_table_id = aws_route_table.pub-rt.id
}


#Public route table association
resource "aws_route_table_association" "pub-rt-2-association" {
  subnet_id      = aws_subnet.pub-sub-2.id
  route_table_id = aws_route_table.pub-rt.id
}


#Private route table association
resource "aws_route_table_association" "pri-rt-1-association" {
  subnet_id      = aws_subnet.pri-sub-1.id
  route_table_id = aws_route_table.pri-rt.id
}

#Public route table association
resource "aws_route_table_association" "pri-rt-2-association" {
  subnet_id      = aws_subnet.pri-sub-2.id
  route_table_id = aws_route_table.pri-rt.id
}

#Internet gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.project1.id

  tags = {
    Name = "igw"
  }
}

#aws route
resource "aws_route" "public-igw-route" {
  route_table_id         = aws_route_table.pub-rt.id
  destination_cidr_block = var.route_cidr
  gateway_id             = aws_internet_gateway.igw.id

}