# Create SSH key pair
resource "tls_private_key" "hodor" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "winterfell" {
  key_name   = var.key_pair_name
  public_key = tls_private_key.hodor.public_key_openssh

  tags = var.tags
}

# Save private key to file
resource "local_file" "winterfell_crypt" {
  content  = tls_private_key.hodor.private_key_pem
  filename = "${var.key_pair_name}.pem"
  file_permission = "0400"
}