output "bastion_instance_id" {
  description = "bastion instance id."
  value       = aws_instance.bastion.id
}

output "bastion_public_ip" {
  description = "bastion public ip."
  value       = aws_instance.bastion.public_ip
}

output "bastion_private_ip" {
  description = "bastion private ip."
  value       = aws_instance.bastion.private_ip
}

output "bastion_private_dns" {
  description = "bastion private dns."
  value       = aws_instance.bastion.private_dns
}

output "key_pair_name" {
  description = "key pair name."
  value       = aws_key_pair.this.key_name
}

output "private_instance_id" {
  description = "Identifiant de l instance privee."
  value       = aws_instance.private.id
}

output "private_instance_ip" {
  description = "Adresse IPv4 privee de l instance applicative."
  value       = aws_instance.private.private_ip
}

output "private_instance_dns" {
  description = "Nom DNS prive de l instance applicative."
  value       = aws_instance.private.private_dns
}
