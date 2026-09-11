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
  description = "Table principale du VPC, sans association aux deux sous-reseaux du TP."
  value       = aws_vpc.this.main_route_table_id
}

output "nat_gateway_id" {
  description = "Identifiant de la passerelle NAT publique."
  value       = aws_nat_gateway.this.id
}

output "nat_eip_allocation_id" {
  description = "Identifiant allocation de l adresse IP elastique de la NAT."
  value       = aws_eip.nat.id
}

output "nat_public_ip" {
  description = "Adresse IPv4 publique de sortie via la NAT."
  value       = aws_eip.nat.public_ip
}

output "private_route_table_id" {
  description = "Table de routage associee au sous-reseau prive."
  value       = aws_route_table.private.id
}
