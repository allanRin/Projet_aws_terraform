variable "numero_poste" {
  description = "Numéro de poste sur deux chiffres, conservé comme chaîne (exemple : 07)."
  type        = string

  validation {
    condition     = can(regex("^[0-9]{2}$", var.numero_poste))
    error_message = "Le numéro de poste doit contenir exactement deux chiffres."
  }
}

variable "ssh_source_cidr" {
  description = "IPv4 publique du poste qui ouvrira SSH, suivie de /32."
  type        = string

  validation {
    condition     = can(cidrnetmask(var.ssh_source_cidr)) && can(regex("/32$", var.ssh_source_cidr))
    error_message = "Indiquer une IPv4 valide suivie de /32 pour autoriser un seul poste."
  }
}

variable "ami_id" {
  description = "AMI Amazon Linux 2023 x86_64 en eu-west-3, fixee pour la duree du TP."
  type        = string

  validation {
    condition     = can(regex("^ami-([0-9a-f]{8}|[0-9a-f]{17})$", var.ami_id))
    error_message = "Indiquer un identifiant AMI valide."
  }
}

variable "ssh_public_key_path" {
  description = "Chemin local vers le fichier .pub ED25519 sur la machine Terraform."
  type        = string

  validation {
    condition     = fileexists(pathexpand(var.ssh_public_key_path))
    error_message = "Le fichier de cle publique doit exister sur la machine Terraform."
  }
}
