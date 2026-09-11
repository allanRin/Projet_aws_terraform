module "vpc" {
  source = "./modules/vpc"

  name_prefix = "tp-${var.numero_poste}"
}

module "security" {
  source = "./modules/security"

  name_prefix     = "tp-${var.numero_poste}"
  vpc_id          = module.vpc.vpc_id
  ssh_source_cidr = var.ssh_source_cidr
}
