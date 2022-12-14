resource "aws_instance" "sonarqube" {

  ami           = "ami-03b755af568109dc3"
  instance_type = "t3.small"
  key_name      = "navadeep"
  subnet_id     = aws_subnet.private_subnet1.id
  security_groups = [aws_security_group.sonarqube-sg.id]
  user_data = file("sonarqube.sh")

  tags = {
    Name = "sonarqube"
  }
}