

module "vpc" {
  source = "terraform-aws-modules/vpc/aws"
  cidr   = var.AWS_VPC_CIDR[terraform.workspace]

  azs            = slice(data.aws_availability_zones.available.names, 0, var.VPC_SUBNET_COUNT[terraform.workspace])
  public_subnets = [for index in range(var.VPC_SUBNET_COUNT[terraform.workspace]) : cidrsubnet(var.AWS_VPC_CIDR[terraform.workspace], 8, index)]

  enable_nat_gateway = false
  enable_vpn_gateway = false

  tags = merge(local.tags, {
    Name = "${local.name_prefix}-vpc"
  })
}


resource "aws_security_group" "nginx_sg" {
  name   = "${local.name_prefix}-nginx-sg"
  vpc_id = module.vpc.vpc_id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = [var.AWS_VPC_CIDR[terraform.workspace]]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = local.tags
}

resource "aws_security_group" "alb_sg" {
  name   = "${local.name_prefix}-alb-sg"
  vpc_id = module.vpc.vpc_id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = local.tags
}