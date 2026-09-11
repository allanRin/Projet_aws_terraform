output "bastion_security_group_id" {
  description = "Groupe de securite a associer au bastion."
  value       = aws_security_group.bastion.id
}

output "private_security_group_id" {
  description = "Groupe de securite a associer a l instance privee."
  value       = aws_security_group.private.id
}
