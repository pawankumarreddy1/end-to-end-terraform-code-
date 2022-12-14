resource "aws_lb" "pavan-test-alb" {
  name               = "pavan-test-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb_sg.id]
  subnets            = [aws_subnet.public_subnet1.id,aws_subnet.public_subnet2.id,aws_subnet.public_subnet3.id]

#   enable_deletion_protection = true

#   access_logs {
#     bucket  = aws_s3_bucket.lb_logs.bucket
#     prefix  = "test-lb"
#     enabled = true
#   }

  tags = {
    Environment = "pavan-alb"
  }
}

resource "aws_lb_target_group" "pavan-tg-jenkins" {
  name     = "tg-jenkins"
  port     = 8080
  protocol = "HTTP"
  vpc_id   = aws_vpc.vpc1.id
}

resource "aws_lb_target_group_attachment" "pavan-tg-attachment-jenkins" {
  target_group_arn = aws_lb_target_group.pavan-tg-jenkins.arn
  target_id        = aws_instance.jeknins.id
  port             = 8080
}


resource "aws_lb_target_group" "pavan-tg-tomcat" {
  name     = "tg-tomcat"
  port     = 8080
  protocol = "HTTP"
  vpc_id   = aws_vpc.vpc1.id
}

resource "aws_lb_target_group_attachment" "pavan-tg-attachment-tomcat" {
  target_group_arn = aws_lb_target_group.pavan-tg-tomcat.arn
  target_id        = aws_instance.tomcat.id
  port             = 8080
}

resource "aws_lb_target_group" "pavan-tg-apache" {
  name     = "tg-apache"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.vpc1.id
}

resource "aws_lb_target_group_attachment" "pavan-tg-attachment-apache" {
  target_group_arn = aws_lb_target_group.pavan-tg-apache.arn
  target_id        = aws_instance.apache.id
  port             = 80
}

resource "aws_lb_target_group" "pavan-tg-nexus" {
  name     = "tg-nexus"
  port     = 8081
  protocol = "HTTP"
  vpc_id   = aws_vpc.vpc1.id
}

resource "aws_lb_target_group_attachment" "pavan-tg-attachment-nexus" {
  target_group_arn = aws_lb_target_group.pavan-tg-nexus.arn
  target_id        = aws_instance.nexus.id
  port             = 8081
}

resource "aws_lb_target_group" "pavan-tg-sonarqube" {
  name     = "tg-sonarqube"
  port     = 9000
  protocol = "HTTP"
  vpc_id   = aws_vpc.vpc1.id
}

resource "aws_lb_target_group_attachment" "pavan-tg-attachment-sonarqube" {
  target_group_arn = aws_lb_target_group.pavan-tg-sonarqube.arn
  target_id        = aws_instance.sonarqube.id
  port             = 9000
}




resource "aws_lb_listener" "pavan-alb-listener" {
  load_balancer_arn = aws_lb.pavan-test-alb.arn
  port              = "80"
  protocol          = "HTTP"
#   ssl_policy        = "ELBSecurityPolicy-2016-08"
#   certificate_arn   = "arn:aws:iam::187416307283:server-certificate/test_cert_rab3wuqwgja25ct3n4jdj2tzu4"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.pavan-tg-jenkins.arn
  }
}

resource "aws_lb_listener_rule" "pavan-jenkins-hostbased" {
  listener_arn = aws_lb_listener.pavan-alb-listener.arn
#   priority     = 99

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.pavan-tg-jenkins.arn
  }

  condition {
    host_header {
      values = ["jenkins.pavan.quest"]
    }
  }
}

resource "aws_lb_listener_rule" "pavan-tomcat-hostbased" {
  listener_arn = aws_lb_listener.pavan-alb-listener.arn
#   priority     = 98

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.pavan-tg-tomcat.arn
  }

  condition {
    host_header {
      values = ["tomcat.pavan.quest"]
    }
  }
}

resource "aws_lb_listener_rule" "pavan-apache-hostbased" {
  listener_arn = aws_lb_listener.pavan-alb-listener.arn
#   priority     = 98

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.pavan-tg-apache.arn
  }

  condition {
    host_header {
      values = ["apache.pavan.quest"]
    }
  }
}

resource "aws_lb_listener_rule" "pavan-nexus-hostbased" {
  listener_arn = aws_lb_listener.pavan-alb-listener.arn
  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.pavan-tg-nexus.arn
  }

  condition {
    host_header {
      values = ["nexus.pavan.quest"]
    }
  }
}
resource "aws_lb_listener_rule" "pavan-sonarqube-hostbased" {
  listener_arn = aws_lb_listener.pavan-alb-listener.arn
  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.pavan-tg-sonarqube.arn
  }

  condition {
    host_header {
      values = ["sonarqube.pavan.quest"]
    }
  }
}



# resource "aws_lb_target_group" "pavan-tg-nexus" {
#   name     = "tg-nexus"
#   port     = 8081
#   protocol = "HTTP"
#   vpc_id   = aws_vpc.vpc1.id
# }

# resource "aws_lb_target_group_attachment" "pavan-tg-attachment-nexus" {
#   target_group_arn = aws_lb_target_group.pavan-tg-nexus.arn
#   target_id        = aws_instance.nexus.id
#   port             = 8081
# }

# resource "aws_lb_listener_rule" "pavan-nexus-hostbased" {
#   listener_arn = aws_lb_listener.pavan-alb-listener.arn
#   action {
#     type             = "forward"
#     target_group_arn = aws_lb_target_group.pavan-tg-nexus.arn
#   }

#   condition {
#     host_header {
#       values = ["nexus.pavan.quest"]
#     }
#   }
# }



resource "aws_lb_target_group" "pavan-tg-promithius" {
  name     = "tg-promithius"
  port     = 9090
  protocol = "HTTP"
  vpc_id   = aws_vpc.vpc1.id
}

resource "aws_lb_target_group_attachment" "pavan-tg-attachment-promithius" {
  target_group_arn = aws_lb_target_group.pavan-tg-promithius.arn
  target_id        = aws_instance.promithius.id
  port             = 9090
}

resource "aws_lb_listener_rule" "pavan-promithius-hostbased" {
  listener_arn = aws_lb_listener.pavan-alb-listener.arn
  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.pavan-tg-promithius.arn
  }

  condition {
    host_header {
      values = ["promithius.pavan.quest"]
    }
  }
}


resource "aws_lb_target_group" "pavan-tg-node-exporter" {
  name     = "tg-node-exporter"
  port     = 9100
  protocol = "HTTP"
  vpc_id   = aws_vpc.vpc1.id
}

resource "aws_lb_target_group_attachment" "pavan-tg-attachment-node-exporter" {
  target_group_arn = aws_lb_target_group.pavan-tg-node-exporter.arn
  target_id        = aws_instance.node-exporter.id
  port             = 9100
}

resource "aws_lb_listener_rule" "pavan-node-exporter-hostbased" {
  listener_arn = aws_lb_listener.pavan-alb-listener.arn
  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.pavan-tg-node-exporter.arn
  }

  condition {
    host_header {
      values = ["node-exporter.pavan.quest"]
    }
  }
}




resource "aws_lb_target_group" "pavan-tg-grafana" {
  name     = "tg-grafana"
  port     = 9090
  protocol = "HTTP"
  vpc_id   = aws_vpc.vpc1.id
}

resource "aws_lb_target_group_attachment" "pavan-tg-attachment-grafana" {
  target_group_arn = aws_lb_target_group.pavan-tg-grafana.arn
  target_id        = aws_instance.grafana.id
  port             = 9090
}

resource "aws_lb_listener_rule" "pavan-grafana-hostbased" {
  listener_arn = aws_lb_listener.pavan-alb-listener.arn
  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.pavan-tg-grafana.arn
  }

  condition {
    host_header {
      values = ["grafana.pavan.quest"]
    }
  }
}

resource "aws_lb_target_group" "pavan-tg-elk" {
  name     = "tg-elk"
  port     = 9200
  protocol = "HTTP"
  vpc_id   = aws_vpc.vpc1.id
}

resource "aws_lb_target_group_attachment" "pavan-tg-attachment-elk" {
  target_group_arn = aws_lb_target_group.pavan-tg-elk.arn
  target_id        = aws_instance.elk.id
  port             = 9200
}

resource "aws_lb_listener_rule" "pavan-elk-hostbased" {
  listener_arn = aws_lb_listener.pavan-alb-listener.arn
  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.pavan-tg-elk.arn
  }

  condition {
    host_header {
      values = ["elk.pavan.quest"]
    }
  }
}


