variable "name_prefix" {
  description = "Prefixe commun aux noms des ressources, par exemple tp-06."
  type        = string
}

variable "vpc_id" {
  description = "Identifiant du VPC recevant les groupes de securite."
  type        = string
}

variable "ssh_source_cidr" {
  description = "IPv4 publique du poste qui ouvrira SSH, suivie de /32."
  type        = string

  validation {
    condition     = can(cidrnetmask(var.ssh_source_cidr)) && can(regex("/32$", var.ssh_source_cidr))
    error_message = "Indiquer une IPv4 valide suivie de /32 pour autoriser un seul poste."
  }
}
