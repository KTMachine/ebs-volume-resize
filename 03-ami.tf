# Data source for Amazon Linux 2 AMI
data "aws_ami" "amazon_linux_2" {
  most_recent = true

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["amazon"]
}

# Determine which AMI to use
locals {
  ami_id = var.use_custom_ami ? var.custom_ami_id : data.aws_ami.amazon_linux_2.id
}
