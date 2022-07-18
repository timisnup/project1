#First instance
resource "aws_instance" "instance" {
  ami                         = "ami-078a289ddf4b09ae0"
  instance_type               = "t2.micro"
  key_name                    = "timmie"
  subnet_id                   = aws_subnet.pub-sub-1.id
  associate_public_ip_address = true
  vpc_security_group_ids      = [aws_security_group.sec-group.id]


  tags = {
    Name = "myinstance1"
  }
}

#second instance
resource "aws_instance" "instance2" {
  ami                         = "ami-030770b178fa9d374"
  instance_type               = "t2.micro"
  key_name                    = "timmie"
  subnet_id                   = aws_subnet.pub-sub-2.id
  associate_public_ip_address = true
  vpc_security_group_ids      = [aws_security_group.sec-group.id]


  tags = {
    Name = "myinstance2"
  }
}