# Get latest Amazon Linux 2023 AMI
data "aws_ami" "amazon_linux" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-*-x86_64"]
  }
}

# EC2 Instance
resource "aws_instance" "ec2" {
  ami           = data.aws_ami.amazon_linux.id
  instance_type = var.instance_type

  subnet_id = "subnet-00fb517ca5f239e07"

  tags = {
    Name = "muhs-terraform-ec2"
  }
}

# EBS Volume (same AZ as EC2)
resource "aws_ebs_volume" "ebs" {
  availability_zone = aws_instance.ec2.availability_zone
  size              = 1

  tags = {
    Name = "terraform-ebs"
  }
}

# Attach EBS to EC2
resource "aws_volume_attachment" "ebs_attach" {
  device_name = "/dev/xvdb"
  volume_id   = aws_ebs_volume.ebs.id
  instance_id = aws_instance.ec2.id
}