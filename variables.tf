variable "numero_poste" {
  description = "Numéro de poste sur deux chiffres, conservé comme chaîne (exemple : 07)."
  type        = string

  validation {
    condition     = can(regex("^[0-9]{2}$", var.numero_poste))
    error_message = "Le numéro de poste doit contenir exactement deux chiffres."
  }
}
