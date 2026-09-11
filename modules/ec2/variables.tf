variable "name_prefix" {
  description = "Prefixe de nommage du TP."
  type        = string
}

variable "public_subnet_id" {
  description = "Sous-reseau public du bastion."
  type        = string
}

variable "bastion_security_group_id" {
  description = "Groupe de securite du bastion."
  type        = string
}

variable "ami_id" {
  description = "AMI Amazon Linux 2023 x86_64 en eu-west-3, fixee pour la duree du TP."
  type        = string

  validation {
    condition     = can(regex("^ami-([0-9a-f]{8}|[0-9a-f]{17})$", var.ami_id))
    error_message = "Indiquer un identifiant AMI valide."
  }
}

variable "ssh_public_key" {
  description = "Cle publique SSH ED25519 ; jamais la cle privee."
  type        = string

  validation {
    condition     = can(regex("^ssh-ed25519 [A-Za-z0-9+/]+={0,3}([ \t].*)?$", trimspace(var.ssh_public_key)))
    error_message = "Fournir une cle publique OpenSSH ED25519."
  }
}
