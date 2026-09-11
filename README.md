# Infrastructure AWS avec Terraform

Déploiement d’un VPC avec sous-réseaux public et privé, passerelle internet, NAT, bastion SSH et instance privée dans la région `eu-west-3`.

## Structure

- `modules/vpc` : réseau et routage.
- `modules/security` : groupes de sécurité et règles SSH.
- `modules/ec2` : instances Amazon Linux et paire de clés publique.
- Fichiers Terraform à la racine : configuration et intégration des modules.

## Prérequis

Terraform >= 1.5 et < 2, AWS CLI authentifiée avec les droits nécessaires, Git et OpenSSH. Vérifier l’accès AWS avec `aws sts get-caller-identity`.

## Lancement

Depuis la racine du dépôt cloné :

```bash
cp terraform.tfvars.example terraform.tfvars
```

Créer une clé sur le poste qui servira aux connexions SSH (ne pas écraser une clé existante) :

```bash
mkdir -p ~/.ssh
chmod 700 ~/.ssh
ssh-keygen -t ed25519 -f ~/.ssh/aws-lab.pem
chmod 400 ~/.ssh/aws-lab.pem
```

Si Terraform tourne sur une autre machine, y transférer uniquement le fichier `.pub`.

Obtenir l’AMI Amazon Linux 2023 x86_64 de la région :

```bash
aws ssm get-parameter --region eu-west-3 \
  --name /aws/service/ami-amazon-linux-latest/al2023-ami-kernel-default-x86_64 \
  --query 'Parameter.Value' --output text
```

Compléter `terraform.tfvars` :

| Variable | Valeur attendue |
|---|---|
| `numero_poste` | Identifiant sur deux chiffres, entre guillemets |
| `ssh_source_cidr` | IPv4 publique du poste SSH suivie de `/32` |
| `ami_id` | Identifiant retourné par la commande précédente |
| `ssh_public_key_path` | Chemin du fichier `.pub` sur la machine Terraform |

Puis exécuter :

```bash
terraform init
terraform fmt -check -recursive
terraform validate
terraform plan -out=deployment.tfplan
terraform apply deployment.tfplan
terraform output
```

Examiner le plan avant application. Un premier déploiement complet prévoit 21 ressources Terraform.

## Connexion

Sur le poste qui possède la clé privée, remplacer les adresses par les outputs `bastion_public_ip` et `private_instance_ip` :

```bash
ssh -i ~/.ssh/aws-lab.pem ec2-user@<IP_BASTION>

ssh -i ~/.ssh/aws-lab.pem \
  -o 'ProxyCommand=ssh -i ~/.ssh/aws-lab.pem -W %h:%p ec2-user@<IP_BASTION>' \
  ec2-user@<IP_PRIVEE>
```

La clé privée reste sur le poste ; elle ne doit pas être copiée sur le bastion.

## Nettoyage

Depuis la même machine et avec le même état Terraform :

```bash
terraform plan -destroy -out=cleanup.tfplan
terraform apply cleanup.tfplan
terraform state list
```

La NAT, les IPv4 publiques et les instances engendrent des frais. Supprimer les ressources après utilisation.

## Gestion du dépôt

Les modules sont développés sur `feature/module-vpc`, `feature/module-security` et `feature/module-ec2`, puis fusionnés avec `--no-ff` pour conserver leur historique.

Versionner `.terraform.lock.hcl`. Ne pas publier les identifiants AWS, clés privées, fichiers `.tfvars`, plans ou états Terraform. Conserver l’état local jusqu’à la suppression complète des ressources.
