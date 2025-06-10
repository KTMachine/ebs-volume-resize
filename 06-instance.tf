# Update EC2 instance resource to include public IP assignment
resource "aws_instance" "winter_is_coming" {
  ami                         = local.ami_id
  instance_type               = var.instance_type
  subnet_id                   = aws_subnet.snow.id
  key_name                    = aws_key_pair.winterfell.key_name
  user_data                   = file(var.user_data_script)
  associate_public_ip_address = var.assign_public_ip

  root_block_device {
    volume_size = var.original_volume_size
    volume_type = var.volume_type
  }

  vpc_security_group_ids = [aws_security_group.allow_ssh.id]

  tags = var.tags

  depends_on = [aws_key_pair.winterfell]
}
