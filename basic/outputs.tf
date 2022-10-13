output "ALB_DNS_HOST_NAME" {
  value = aws_lb.nginx_alb.dns_name
}

output "EC2_INSTANCES_DNS_HOST_NAME" {
  value = aws_instance.ec2_instances[*].public_dns
}