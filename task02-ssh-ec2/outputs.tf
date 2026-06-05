output "instance_id" {
  description = "ID of the created EC2 instance"
  value       = aws_instance.main.id
}

output "instance_public_ip" {
  description = "Public IP address of the EC2 instance"
  value       = aws_instance.main.public_ip
}

output "keypair_name" {
  description = "Name of the created AWS keyh pair"
  value       = aws_key_pair.main.key_name
}