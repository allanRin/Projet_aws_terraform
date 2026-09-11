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
  description = "Table principale encore utilisee implicitement par le sous-reseau prive."
  value       = module.vpc.main_route_table_id
}
