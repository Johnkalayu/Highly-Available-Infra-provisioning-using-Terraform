resource "aws_lb" "app-load-balancer" {
    name = "app-load-balancer"
    internal = false
    load_balancer_typr = "application"
    security_group_id = [aws_securirty_group.alb-sg-region1]
    subnet_id = [aws_subnet.private-subnet-1.id, aws_subnet.private-subnet-2.id]

    enable_deletion_protection = false

}
resource "aws_lb_target_group" "alb-target-group" {
    name = "alb-target-group"
    port = 8080
    protocol = "HTTP"
    traget_type = "inastance"
    vpc_id = aws+vpc.dev-vpc.vpc_id

    health_check {
        enable = true
        interval = 300
        patch = "/"
        timeout = 60
        matcher = 200
        healthy_threshold = 5
        unhealthy_threshold = 5

    }
    lifecycle {
      create_before_destroy = true
    }
  
}

resource "aws_lb_lisner" "alb-lesner" {
    load_balancer_arn = aws_lb.app-load-balancer.arn
    port = 80
    protocol = "HTTP"

    default_action {
        typ = "forward"
        target_group_arn = aws_lb_target_group.alb-target-group.arn
    }
}