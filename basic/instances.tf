resource "aws_instance" "ec2_instances" {
  count                  = var.EC2_INSTANCE_COUNT[terraform.workspace]
  ami                    = nonsensitive(data.aws_ssm_parameter.ami.value)
  instance_type          = var.EC2_INSTANCE_SIZE[terraform.workspace]
  vpc_security_group_ids = [aws_security_group.nginx_sg.id]
  subnet_id              = module.vpc.public_subnets[count.index % var.VPC_SUBNET_COUNT[terraform.workspace]]
  #  user_data              = data.template_file.ec2_instance_userdata.rendered
  user_data = templatefile("${path.module}/userdata.sh", {
    s3_bucket_name = module.aws_web_s3.web_bucket.id
  })
  iam_instance_profile = module.aws_web_s3.instance_profile.name
  depends_on           = [module.aws_web_s3]
  tags = merge(local.tags, {
    Name = "${local.name_prefix}-instance${count.index}"
  })
}