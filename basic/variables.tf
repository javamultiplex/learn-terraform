variable "NAME_PREFIX" {
  type        = string
  description = "Naming prefix for all resources"
  default     = "globoweb"
}

variable "AWS_REGION" {
  type        = string
  description = "AWS Region"
  default     = "eu-west-1"
}

variable "AWS_VPC_CIDR" {
  type        = map(string)
  description = "AWS VPC CIDR"
}


variable "VPC_SUBNET_COUNT" {
  type        = map(number)
  description = "Number of subnets to create"
}

variable "AWS_VPC_SUBNETS_CIDR" {
  type        = list(string)
  description = "AWS VPC Subnets CIDR"
  default     = ["10.0.0.0/24", "10.0.1.0/24"]
}

variable "ENABLE_DNS_HOSTNAMES" {
  type        = bool
  description = "Enable DNS Hostnames in VPC"
  default     = true
}

variable "MAP_PUBLIC_IP_ON_LAUNCH" {
  type        = bool
  description = "MAP Public IP on Launch"
  default     = true
}

variable "EC2_AMI_NAME" {
  type        = string
  description = "EC2 AMI Name"
  default     = "/aws/service/ami-amazon-linux-latest/amzn2-ami-hvm-x86_64-gp2"
}

variable "EC2_INSTANCE_SIZE" {
  type        = map(string)
  description = "EC2 Instance Size"
}

variable "EC2_INSTANCE_COUNT" {
  type        = map(number)
  description = "Number of EC2 instances to create"
}

variable "PROJECT_NAME" {
  type        = string
  description = "Project Name"
  default     = "Learn Terraform"
}