module "vpc" {
  source = "./modules/vpc"

  name_prefix = "tp-${var.numero_poste}"
}
