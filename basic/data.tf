data "aws_elb_service_account" "root" {}

data "aws_ssm_parameter" "ami" {
  name = var.EC2_AMI_NAME
}

data "aws_availability_zones" "available" {
  state = "available"
}

data "template_file" "ec2_instance_userdata" {
  template = file("./userdata.sh")
  vars = {
    s3_bucket_name = module.aws_web_s3.web_bucket.id
  }
}

data "aws_iam_policy_document" "s3_bucket_policy_for_alb_access_logs" {
  statement {
    effect = "Allow"
    principals {
      identifiers = [data.aws_elb_service_account.root.arn]
      type        = "AWS"
    }
    actions   = ["s3:PutObject"]
    resources = ["arn:aws:s3:::${local.s3_bucket_name}/alb-logs/*"]
  }
}

data "aws_iam_policy_document" "ec2_instance_assume_policy" {
  statement {
    effect = "Allow"
    principals {
      identifiers = ["ec2.amazonaws.com"]
      type        = "Service"
    }
    actions = ["sts:AssumeRole"]
  }
}

data "aws_iam_policy_document" "s3_full_access_policy" {
  statement {
    effect  = "Allow"
    actions = ["s3:*"]
    resources = [
      "arn:aws:s3:::${local.s3_bucket_name}",
      "arn:aws:s3:::${local.s3_bucket_name}/*"
    ]
  }
}