#security_group
resource "aws_instance" "elk" {

  ami           = "ami-0f15e0a4c8d3ee5fe"
  instance_type = "t2.micro"
  key_name      = "navadeep"
  subnet_id     = aws_subnet.private_subnet1.id
  security_groups = [aws_security_group.elk-sg.id]
  user_data = file("elk.sh")

  tags = {
    Name = "elk"
  }
}

  