resource "aws_instance" "green" {
  ami                         = data.aws_ami.amazon-linux-2.id
  instance_type               = var.create_instance[1].ec2_type
  subnet_id                   = aws_subnet.main3.id
  vpc_security_group_ids      = [aws_security_group.group-4.id]
  user_data                   = file("green.sh")
  user_data_replace_on_change = true

  tags = {
    Name = var.create_instance[1].ec2_name
  }
}
# output ec2-2 {
#   value = aws_instance.green.public_ip
# }

resource "aws_lb_target_group" "green" {
  name     = var.lb_target_group[0].lb_tg_name
  port     = var.lb_target_group[1].lb_tg_port
  protocol = var.lb_target_group[2].lb_tg_protocol
  vpc_id   = aws_vpc.project.id

  health_check {
    path     = "/health"
    port     = var.lb_target_group[1].lb_tg_port
    protocol = var.lb_target_group[2].lb_tg_protocol
    timeout  = 5
    interval = 10
  }
}
resource "aws_lb_target_group_attachment" "green-group-4" {
  target_group_arn = aws_lb_target_group.green.arn
  target_id        = aws_instance.green.id
  port             = var.lb_target_group[1].lb_tg_port
  depends_on = [
    aws_lb_target_group.green,
    aws_instance.green
  ]
}
resource "aws_lb_listener" "listener_elb1" {
  load_balancer_arn = aws_lb.external-alb.arn
  port              = var.lb_target_group[1].lb_tg_port
  protocol          = var.lb_target_group[2].lb_tg_protocol
  default_action {
    type = "forward"
    target_group_arn = aws_lb_target_group.green.arn
    # forward {
    #   target_group {
    #     arn    = aws_lb_target_group.blue.arn
    #     weight = lookup(local.traffic_dist_map[var.traffic_distribution], "blue", 100)
    #   }

    #   target_group {
    #     arn    = aws_lb_target_group.green.arn
    #     weight = lookup(local.traffic_dist_map[var.traffic_distribution], "green", 0)
    #   }

    #   stickiness {
    #     enabled  = false
    #     duration = 1
    #   }
    # }
  }
}