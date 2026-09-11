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
