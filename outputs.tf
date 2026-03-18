output "instance_id" {
  value = aws_instance.ec2.id
}

output "availability_zone" {
  value = aws_instance.ec2.availability_zone
}

output "ebs_volume_id" {
  value = aws_ebs_volume.ebs.id
}