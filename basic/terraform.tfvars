AWS_VPC_CIDR = {
  Development = "10.0.0.0/16"
  UAT         = "10.1.0.0/16"
  PROD        = "10.2.0.0/16"
}

EC2_INSTANCE_COUNT = {
  Development = 2
  UAT         = 4
  PROD        = 6
}

EC2_INSTANCE_SIZE = {
  Development = "t2.micro"
  UAT         = "t2.small"
  PROD        = "t2.medium"
}

VPC_SUBNET_COUNT = {
  Development = 2
  UAT         = 2
  PROD        = 3
}