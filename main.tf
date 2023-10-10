#EC2 Instance 생성
data "aws_ami" "ubuntu" {
  most_recent = true
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-bionic-18.04-amd64-server-*"]
  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
  owners = ["099720109477"] # Canonical
}
resource "aws_eip" "tfdemo" {
  instance = aws_instance.tfdemo.id
  vpc      = true
}
resource "aws_eip_association" "tfdemo" {
  instance_id   = aws_instance.tfdemo.id
  allocation_id = aws_eip.tfdemo.id
}
resource "aws_instance" "tfdemo" {
  ami                         = data.aws_ami.ubuntu.id
  instance_type               = var.instance_type
  associate_public_ip_address = true
  subnet_id                   = var.subnet_id
  vpc_security_group_ids      = [var.security_group]

  tags = {
    Name       = "${var.prefix}-tfdemo-instance"
    Department = "ops"
    Billable = "true"
  }
}
