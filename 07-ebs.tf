# Resize the EBS volume
resource "aws_ebs_volume" "sansa" {
  availability_zone = aws_instance.winter_is_coming.availability_zone
  size              = var.resized_volume_size
  type              = var.volume_type
  tags              = var.tags
}

# Attach the resized volume to the instance
resource "aws_volume_attachment" "arya" {
  device_name = "/dev/sdh"
  volume_id   = aws_ebs_volume.sansa.id
  instance_id = aws_instance.winter_is_coming.id
  skip_destroy = true # Prevent detachment during destroy
}