resource "aws_instance" "bastion" {

  ami           = "ami-0f15e0a4c8d3ee5fe"
  instance_type = "t2.micro"
  key_name      = "navadeep"
  subnet_id     = aws_subnet.public_subnet1.id

  security_groups = [aws_security_group.bastion-sg.id]
  tags = {
    Name = "bastion"
  }
}