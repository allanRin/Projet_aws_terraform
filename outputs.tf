output "vpc_id" {
  description = "Identifiant du VPC à relever pour l'exercice 1."
  value       = module.vpc.vpc_id
}

output "public_subnet_id" {
  description = "Identifiant du sous-réseau public."
  value       = module.vpc.public_subnet_id
}

output "private_subnet_id" {
  description = "Identifiant du sous-réseau privé."
  value       = module.vpc.private_subnet_id
}

output "numero_poste" {
  description = "Numéro utilisé dans les noms des ressources et le fichier de réponses."
  value       = var.numero_poste
}

output "internet_gateway_id" {
  description = "Identifiant de la passerelle internet attachee au VPC."
  value       = module.vpc.internet_gateway_id
}

output "public_route_table_id" {
  description = "Table de routage associee au sous-reseau public."
  value       = module.vpc.public_route_table_id
}

output "main_route_table_id" {
  description = "Table principale du VPC, sans association aux deux sous-reseaux du TP."
  value       = module.vpc.main_route_table_id
}

output "nat_gateway_id" {
  description = "Identifiant de la passerelle NAT publique."
  value       = module.vpc.nat_gateway_id
}

output "nat_eip_allocation_id" {
  description = "Identifiant allocation de l adresse IP elastique de la NAT."
  value       = module.vpc.nat_eip_allocation_id
}

output "nat_public_ip" {
  description = "Adresse IPv4 publique de sortie via la NAT."
  value       = module.vpc.nat_public_ip
}

output "private_route_table_id" {
  description = "Table de routage associee au sous-reseau prive."
  value       = module.vpc.private_route_table_id
}
