resource "aws_instance" "nexus" {

  ami           = "ami-0f15e0a4c8d3ee5fe"
  instance_type = "t3.medium"
  key_name      = "navadeep"
  subnet_id     = aws_subnet.private_subnet1.id

  security_groups = [aws_security_group.nexus-sg.id]
  user_data = file("nexus.sh")

  tags = {
    Name = "nexus"
  }
}