#creating tg

resource "aws_alb_target_group" "motogp-tg" {
    name = var.tg_name  #target group name
    port = 80
    protocol = var.protocol_tg #http protocol 
    vpc_id = var.vpc_id_tg 
    health_check {
      enabled = true
      healthy_threshold = 3
      interval = 10
      matcher = 200
      path = "/"
      port = "traffic-port"
      protocol = var.protocol_tg
      timeout = 3
      unhealthy_threshold = 2
    }
  
}

#attaching tg to aws instance

resource "aws_lb_target_group_attachment" "motogp-tg-attach" {
    target_group_arn = aws_alb_target_group.motogp-tg.id
    target_id = var.target_id_ec2 #mention ec2 id
    port = 80
  
}

#creating lb

resource "aws_lb" "motogp-lb" {
    name = var.lb_name
    internal = false
    load_balancer_type = var.load_balancer_type
    security_groups = var.security_groups_mg
    subnets = [var.subnets_mg , var.subnets2_mg]
    enable_deletion_protection = false
    tags = {
      Environment = var.Environment
    }
  
}

#creating listener

resource "aws_lb_listener" "motogp-listener" {
    load_balancer_arn = aws_lb.motogp-lb.arn
    port = 80
    protocol = var.protocol_tg

    default_action {
      type = "forward"
      target_group_arn = aws_alb_target_group.motogp-tg.arn
    }
  
}