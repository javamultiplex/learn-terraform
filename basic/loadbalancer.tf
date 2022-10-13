resource "aws_lb" "nginx_alb" {
  name                       = "${local.name_prefix}-alb"
  internal                   = false
  load_balancer_type         = "application"
  security_groups            = [aws_security_group.alb_sg.id]
  subnets                    = module.vpc.public_subnets
  enable_deletion_protection = false
  tags                       = local.tags
  access_logs {
    bucket  = module.aws_web_s3.web_bucket.id
    prefix  = "alb-logs"
    enabled = true
  }
}

resource "aws_lb_target_group" "nginx_tg" {
  name     = "${local.name_prefix}-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = module.vpc.vpc_id
  tags     = local.tags
}

resource "aws_lb_listener" "nginx_alb_listener" {
  load_balancer_arn = aws_lb.nginx_alb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.nginx_tg.arn
  }
  tags = local.tags
}

resource "aws_lb_target_group_attachment" "nginx_tg_ec2_instances" {
  count            = var.EC2_INSTANCE_COUNT[terraform.workspace]
  target_group_arn = aws_lb_target_group.nginx_tg.arn
  target_id        = aws_instance.ec2_instances[count.index].id
  port             = 80
}