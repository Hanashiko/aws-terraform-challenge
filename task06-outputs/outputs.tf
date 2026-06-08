output "vpc_id" {
  description = "ID of the created VPC"
  value       = aws_vpc.main.id
}

output "vpc_cidr" {
  description = "CIDR block of the created VPC"
  value       = aws_vpc.main.cidr_block
}

output "public_subnet_ids" {
  description = "IDs of all public subnets"
  value       = aws_subnet.public[*].id
}

output "public_subnet_cidr_block" {
  description = "CIDR blocks of all public subnets"
  value       = aws_subnet.public[*].cidr_block
}

output "public_subnet_availability_zone" {
  description = "Availability zones of all public subnets"
  value       = aws_subnet.public[*].availability_zone
}

output "internet_gateway_id" {
  description = "ID of the created Internet Gateway"
  value       = aws_internet_gateway.main.id
}

output "routing_table_id" {
  description = "ID of the public route table"
  value       = aws_route_table.public.id
}