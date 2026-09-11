# TP AWS avec Terraform — Exercice 1

Ce premier exercice crée trois ressources gérées par Terraform : un VPC et deux sous-réseaux dans `eu-west-3a` (région Paris, `eu-west-3`). Le module `vpc` contient le réseau ; les fichiers à la racine configurent Terraform et appellent ce module.

```text
.
├── .gitignore
├── README.md
├── provider.tf
├── main.tf
├── variables.tf
├── outputs.tf
├── terraform.tfvars.example
└── modules/
    └── vpc/
        ├── main.tf
        ├── variables.tf
        └── outputs.tf
```

`terraform.tfvars` sera créé sur la VM et restera local. `.terraform.lock.hcl`, généré par `terraform init`, doit être commité : contrairement à la capture du cours, ne pas ignorer ce fichier ni `.gitignore`. Les modules `security` et `ec2` seront développés lors des exercices correspondants, chacun sur sa propre branche.

## Configuration obtenue

| Ressource | Nom | Paramètres |
|---|---|---|
| VPC | tp-NN-vpc | 10.0.0.0/16, résolution DNS et noms d'hôtes DNS activés |
| Sous-réseau public | tp-NN-public-a | 10.0.1.0/24, eu-west-3a, IPv4 publique automatique activée |
| Sous-réseau privé | tp-NN-prive-a | 10.0.11.0/24, eu-west-3a, IPv4 publique automatique désactivée |

Les CIDR et la zone sont fixés dans le module pour respecter le sujet. `numero_poste` est une chaîne obligatoire de deux chiffres. Les références `aws_vpc.this.id` imposent automatiquement la création du VPC avant ses sous-réseaux. Les outputs exposent les identifiants pour les relevés et les futurs modules.

À ce stade, le sous-réseau nommé public n'a pas encore de route vers internet. Aucune passerelle internet, NAT, instance ou règle SSH n'est créée. AWS crée néanmoins automatiquement les objets par défaut du VPC (table principale, groupe de sécurité par défaut, ACL réseau) : c'est le comportement normal de création d'un VPC seul.

## 1. Publier depuis le poste de développement

Après vérification des commits locaux :

```bash
cd /home/allan/Documents/Formation/AJC/AWS/Terraform_sur_aws/Projet_aws_terraform
git log --graph --oneline --decorate --all
git push origin main feature/module-vpc
```

Le push est à effectuer par toi. La branche `feature/module-vpc` est conservée et le merge utilise `--no-ff` : un commit de fusion à deux parents reste visible, même si la branche est supprimée ultérieurement. Ne pas utiliser de squash ni de rebase pour cette fusion.

## 2. Récupérer sur la VM

Si le dépôt est déjà cloné, depuis son dossier :

```bash
git switch main
git pull --ff-only origin main
git fetch origin
```

Sinon :

```bash
git clone git@github.com:allanRin/Projet_aws_terraform.git
cd Projet_aws_terraform
```

Le clone SSH suppose une clé GitHub configurée sur la VM ; HTTPS est aussi possible. Toutes les commandes Terraform suivantes se lancent à la racine du dépôt, jamais dans `modules/vpc`.

## 3. Préparer et déployer

Pré requis : Terraform >= 1.5 et < 2, AWS CLI et authentification AWS déjà configurée avec les droits de gestion VPC/sous-réseaux. Le provider utilise cette authentification, sans clés AWS dans les fichiers Terraform.

```bash
terraform version
aws sts get-caller-identity
cp terraform.tfvars.example terraform.tfvars
nano terraform.tfvars
```

Remplacer `NN` par ton numéro réel, en gardant les guillemets (exemple : `numero_poste = "07"`). Le placeholder `NN` est volontairement refusé par la validation.

```bash
terraform init
terraform fmt -check -recursive
terraform validate
terraform plan -out=exercice1.tfplan
```

Pour un état neuf, le plan attendu est **3 ajouts, 0 modification, 0 suppression**. Vérifier les noms, les CIDR, les DNS et l'attribution d'IP, puis appliquer le plan examiné :

```bash
terraform apply exercice1.tfplan
terraform output
```

Ne pas relancer une copie de ce projet avec un état vide pour gérer ces mêmes ressources. Terraform ne reprend pas automatiquement les ressources de ton ancien TP : s'il en reste, vérifier leur situation avant d'appliquer. Conserver le fichier `terraform.tfstate` sur cette VM pour les exercices suivants et le nettoyage ; Git ne le transporte pas.

Après le premier init, versionner le verrou du provider sur sa branche dédiée, puis fusionner sans fast-forward (arbre Git propre au départ) :

```bash
git switch feature/module-vpc || git switch --track origin/feature/module-vpc
git add .terraform.lock.hcl
git commit -m "build(vpc): verrouiller la version du provider AWS"
git switch main
git merge --no-ff feature/module-vpc -m "merge: verrou du provider du module VPC"
git push origin main feature/module-vpc
```

Si le verrou est déjà versionné et inchangé, sauter ce bloc. Les ressources AWS et l'état local restent identiques pendant ces changements de branche.

## 4. Contrôler les résultats et remplir les réponses

Dans la console AWS, région Paris : vérifier les deux attributs DNS du VPC, les CIDR et zones des sous-réseaux, leur attribution automatique d'IPv4 publique et leur nombre d'IPv4 disponibles. Les commandes suivantes permettent aussi de contrôler les valeurs réelles :

```bash
VPC_ID=$(terraform output -raw vpc_id)
PUBLIC_ID=$(terraform output -raw public_subnet_id)
PRIVATE_ID=$(terraform output -raw private_subnet_id)
aws ec2 describe-vpc-attribute --region eu-west-3 --vpc-id "$VPC_ID" --attribute enableDnsSupport
aws ec2 describe-vpc-attribute --region eu-west-3 --vpc-id "$VPC_ID" --attribute enableDnsHostnames
aws ec2 describe-subnets --region eu-west-3 --subnet-ids "$PUBLIC_ID" "$PRIVATE_ID" --query 'Subnets[].{ID:SubnetId,CIDR:CidrBlock,AZ:AvailabilityZone,IPPubliqueAuto:MapPublicIpOnLaunch,Disponibles:AvailableIpAddressCount}' --output table
```

Un `/24` contient 256 adresses. AWS réserve les quatre premières et la dernière, soit 5 : un sous-réseau vide offre donc **251 adresses disponibles**. Pour `10.0.1.0/24`, les adresses réservées sont `.0` (réseau), `.1` (routeur), `.2` (réservée pour DNS), `.3` (usage futur) et `.255` (broadcast réservé, non pris en charge). Le nombre disponible diminue si des interfaces réseau consomment des adresses.

Pour créer le relevé initial (à exécuter une seule fois ; ce bloc remplace le fichier) :

```bash
NN=$(terraform output -raw numero_poste)
{
  printf 'Exercice 1 - VPC : %s\n' "$VPC_ID"
  printf 'Exercice 1 - Sous-reseau public : %s\n' "$PUBLIC_ID"
  printf 'Exercice 1 - Sous-reseau prive : %s\n' "$PRIVATE_ID"
  printf 'Exercice 1 - Adresses disponibles observees : A COMPLETER depuis la console\n'
  printf 'Exercice 1 - Explication : un /24 contient 256 adresses, dont 5 reservees par AWS, soit 251 disponibles avant toute allocation.\n'
} > "reponses-${NN}.txt"
```

Compléter la valeur observée et conserver ce fichier pour la suite. Il est ignoré par Git pour éviter de publier les relevés propres à ton compte.

## 5. Montrer le développement par branche

```bash
git branch -a
git log --all --graph --decorate --oneline
git log --merges --oneline
git log feature/module-vpc -- modules/vpc
```

Pour un futur module, partir de main à jour, créer sa branche, y développer et commiter, puis revenir sur main pour fusionner :

```bash
git switch main
git switch -c feature/module-security
# Développer modules/security et son intégration dans les fichiers racine.
git add modules/security main.tf variables.tf outputs.tf
git commit -m "feat(security): ajouter les groupes de securite"
git switch main
git merge --no-ff feature/module-security -m "merge: module security"
git push origin main feature/module-security
```

Ces commandes du futur module sont un exemple pour la suite ; elles ne sont pas à exécuter pour l'exercice 1. Le même principe s'applique à `feature/module-ec2`. Les évolutions du réseau peuvent être développées en reprenant `feature/module-vpc` après une fusion de main dans cette branche.

## 6. Nettoyage

Garder les ressources si tu enchaînes l'exercice 2. Si tu arrêtes le TP et souhaites les supprimer, depuis la même VM et avec le même état :

```bash
terraform plan -destroy -out=nettoyage.tfplan
terraform apply nettoyage.tfplan
```

Examiner le plan avant l'application. Terraform détruit les sous-réseaux avant le VPC grâce aux dépendances. Ne pas supprimer le fichier d'état avant le nettoyage.

## Documentation officielle

- VPC Terraform : https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc
- Sous-réseau Terraform : https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet
- Adresses réservées AWS : https://docs.aws.amazon.com/vpc/latest/userguide/subnet-sizing.html
- Verrou Terraform à versionner : https://developer.hashicorp.com/terraform/language/files/dependency-lock
