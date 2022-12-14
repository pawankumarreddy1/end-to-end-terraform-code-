resource "aws_instance" "jeknins" {

  ami           = "ami-0f15e0a4c8d3ee5fe"
  instance_type = "t2.small"
  key_name      = "navadeep"
  subnet_id     = aws_subnet.private_subnet1.id
  security_groups = [aws_security_group.jenkins-sg.id]
  user_data = file("jenkins.sh")

  tags = {
    Name = "jenkins"
  }
}