resource "aws_s3_bucket" "s3_bucket" {
  bucket        = var.bucket_name
  force_destroy = true
  tags          = var.common_tags
}

resource "aws_s3_bucket_acl" "s3_bucket_acl" {
  bucket = aws_s3_bucket.s3_bucket.id
  acl    = "private"
}

resource "aws_s3_bucket_policy" "s3_bucket_policy" {
  bucket = aws_s3_bucket.s3_bucket.id
  policy = <<POLICY
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Principal": {
                "AWS": "${var.elb_service_account_arn}"
            },
            "Action": [
                "s3:PutObject"
            ],
            "Resource": [
                "arn:aws:s3:::${var.bucket_name}/alb-logs/*"
            ]
        }
    ]
}
POLICY
}

resource "aws_iam_role" "nginx_role" {
  name               = "${var.bucket_name}-nginx-instance-role"
  assume_role_policy = <<POLICY
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Principal": {
                "Service": [
                    "ec2.amazonaws.com"
                ]
            },
            "Action": [
                "sts:AssumeRole"
            ]
        }
    ]
}
POLICY
  tags               = var.common_tags
}

resource "aws_iam_role_policy" "nginx_role_policy" {
  name   = "${var.bucket_name}-nginx-instance-role-policy"
  policy = <<POLICY
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "s3:*"
            ],
            "Resource": [
                "arn:aws:s3:::${var.bucket_name}",
                "arn:aws:s3:::${var.bucket_name}/*"
            ]
        }
    ]
}
POLICY
  role   = aws_iam_role.nginx_role.id
}

resource "aws_iam_instance_profile" "nginx_instance_profile" {
  name = "${var.bucket_name}-nginx-instance-profile"
  role = aws_iam_role.nginx_role.id
  tags = var.common_tags
}