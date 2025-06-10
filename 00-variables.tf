variable "aws_region" {
  description = "AWS region where resources will be created"
  type = string 
  default = "us-east-1"
}

variable "instance_type" {
  description = "EC2 instance type"
  type = string 
  default = "t2.micro"
}

variable "use_custom_ami" {
  description = "Use a custom AMI for the EC2 instance"
  type = bool
  default = false
}

variable "custom_ami_id" {
  description = "Custom AMI ID to use if use_custom_ami is true"
  type = string
  default = ""
}

variable  "original_volume_size" {
  description = "Initial size of the EBS volume in GB"
  type = number
  default = 8
}

variable "resized_volume_size" {
  description = "Size to resize the EBS volume to in GB"
  type = number
  default = 16
}

variable "volume_type" {
  description = "Type of EBS volume"
  type = string
  default = "gp3"
}

variable "key_pair_name" {
  description = "Name for the SSH key pair"
  type = string
  default = "resize-key-pair"
}

variable "tags" {
  description = "Tags to apply to resources"
  type = map(string)
  default = {
    Environment = "Test"
    Project = "EBS Resize"
  }
}

variable "user_data_script" {
  description = "Path to user data script for filesystem extension"
  type = string
  default = "scripts/extend_fs.sh"
}

variable "assign_public_ip" {
  description = "Whether to assign a public IP to the instance"
  type        = bool
  default     = true
}

variable "create_public_dns" {
  description = "Whether to create a public DNS record for the instance"
  type        = bool
  default     = true
}

variable "dns_zone_name" {
  description = "Route53 hosted zone name for DNS record (e.g., example.com)"
  type        = string
  default     = ""
}

variable "dns_record_name" {
  description = "DNS record name to create (e.g., ebs-resize)"
  type        = string
  default     = "ebs-resize"
}