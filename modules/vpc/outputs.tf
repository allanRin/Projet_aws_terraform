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

output "internet_gateway_id" {
  description = "Identifiant de la passerelle internet attachee au VPC."
  value       = aws_internet_gateway.this.id
}

output "public_route_table_id" {
  description = "Table de routage associee au sous-reseau public."
  value       = aws_route_table.public.id
}

output "main_route_table_id" {
  description = "Table principale encore utilisee implicitement par le sous-reseau prive."
  value       = aws_vpc.this.main_route_table_id
}
