terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 6.0, < 7.0"
    }
  }
}

resource "aws_security_group" "bastion" {
  name        = "${var.name_prefix}-sg-bastion"
  description = "SSH depuis le poste de formation"
  vpc_id      = var.vpc_id

  tags = {
    Name = "${var.name_prefix}-sg-bastion"
  }
}

resource "aws_security_group" "private" {
  name        = "${var.name_prefix}-sg-prive"
  description = "SSH depuis le groupe du bastion"
  vpc_id      = var.vpc_id

  tags = {
    Name = "${var.name_prefix}-sg-prive"
  }
}

resource "aws_vpc_security_group_ingress_rule" "bastion_ssh" {
  security_group_id = aws_security_group.bastion.id
  description       = "SSH depuis l IPv4 publique du poste uniquement"
  cidr_ipv4         = var.ssh_source_cidr
  ip_protocol       = "tcp"
  from_port         = 22
  to_port           = 22
}

resource "aws_vpc_security_group_ingress_rule" "private_ssh" {
  security_group_id            = aws_security_group.private.id
  description                  = "SSH depuis les instances du groupe bastion"
  referenced_security_group_id = aws_security_group.bastion.id
  ip_protocol                  = "tcp"
  from_port                    = 22
  to_port                      = 22
}

# Terraform retire la sortie par defaut : on recree explicitement son equivalent IPv4.
resource "aws_vpc_security_group_egress_rule" "bastion_all" {
  security_group_id = aws_security_group.bastion.id
  description       = "Tout trafic sortant IPv4"
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"
}

resource "aws_vpc_security_group_egress_rule" "private_all" {
  security_group_id = aws_security_group.private.id
  description       = "Tout trafic sortant IPv4"
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"
}
