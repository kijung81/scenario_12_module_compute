# Outputs file
output "ec2_instance_url" {
  value = aws_instance.tfdemo.public_ip
}

