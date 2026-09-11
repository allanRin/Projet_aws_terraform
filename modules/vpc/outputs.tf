output "vpc_id" {
  description = "Identifiant du VPC créé."
  value       = aws_vpc.this.id
}

output "public_subnet_id" {
  description = "Identifiant du sous-réseau public."
  value       = aws_subnet.public.id
}

output "private_subnet_id" {
  description = "Identifiant du sous-réseau privé."
  value       = aws_subnet.private.id
}
