terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.27"
    }
  }

  required_version = ">= 0.14.9"
}

provider "aws" {
  profile = "default"
  region  = "ap-south-1"
}

resource "aws_instance" "app_server" {
  ami                    = "ami-0a23ccb2cdd9286bb"
  instance_type          = "t2.micro"
  vpc_security_group_ids = ["sg-042fe8420134bc50c"]
  subnet_id              = "subnet-003b1906276f2b40a"

  tags = {
    Name = var.instance_name
  }
}
