output "instance_id" {
  description = "ID of the EC2 instance"
  value       = aws_instance.winter_is_coming.id
}

output "original_volume_id" {
  description = "ID of the original EBS volume"
  value       = aws_instance.winter_is_coming.root_block_device[0].volume_id
}

output "resized_volume_id" {
  description = "ID of the resized EBS volume"
  value       = aws_ebs_volume.sansa.id
}

output "instance_public_ip" {
  description = "Public IP address of the EC2 instance"
  value       = aws_instance.winter_is_coming.public_ip
}

output "private_key_saved" {
  description = "Location where the private key was saved"
  value       = "${abspath(path.root)}/${var.key_pair_name}.pem"
}

output "volume_resize_notice" {
  description = "Instructions for completing the volume resize"
  value       = <<EOT
The new volume has been attached to the instance. To use it:
1. SSH into the instance: ${"ssh -i ${var.key_pair_name}.pem ec2-user@${aws_instance.winter_is_coming.public_ip}"}
2. The attached volume should be available at /mnt/resized_volume

For root volume resizing, you would need to:
1. Stop the instance
2. Modify the root volume size in AWS console
3. Start the instance
4. Extend the filesystem using the appropriate commands
EOT
}

output "public_dns_name" {
  description = "Public DNS name of the instance"
  value       = aws_instance.winter_is_coming.public_dns
}

output "public_ip" {
  description = "Public IP address of the EC2 instance"
  value       = aws_instance.winter_is_coming.public_ip
}

output "route53_dns_name" {
  description = "Route53 DNS name if created"
  value       = var.create_public_dns && var.dns_zone_name != "" ? aws_route53_record.instance[0].fqdn : null
}

output "ssh_connection_command" {
  description = "Command to SSH into the instance"
  value       = "ssh -i ${var.key_pair_name}.pem ec2-user@${var.create_public_dns && var.dns_zone_name != "" ? aws_route53_record.instance[0].fqdn : aws_instance.winter_is_coming.public_ip}"
}