output "vpc_security_group_ids" {
  description = "List of VPC security group ids assigned to the instances"
  value       = "${aws_instance.example.vpc_security_group_ids}"
}

output "tags" {
  description = "List of tags"
  value       = "${aws_instance.example.tags}"
}

output "instance_id" {
  description = "EC2 instance ID"
  value       = "${aws_instance.example.id}"
}

output "instance_public_dns" {
  description = "Public DNS name assigned to the EC2 instance"
  value       = "${aws_instance.example.public_dns}"
}

output "instance_public_ip" {
  description = "Public IP name assigned to the EC2 instance"
  value       = "${aws_instance.example.public_ip}"
}
