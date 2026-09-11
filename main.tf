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

module "ec2" {
  source = "./modules/ec2"

  name_prefix               = "tp-${var.numero_poste}"
  ami_id                    = var.ami_id
  public_subnet_id          = module.vpc.public_subnet_id
  bastion_security_group_id = module.security.bastion_security_group_id
  ssh_public_key            = trimspace(file(pathexpand(var.ssh_public_key_path)))

  # Attendre aussi les regles SSH et le routage avant de lancer le bastion.
  depends_on = [module.vpc, module.security]
}
