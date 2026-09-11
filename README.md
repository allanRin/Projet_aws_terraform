## EXO 1 VPC

```bash
dev@DESKTOP-P6CCGSP:~/Projet_aws_terraform$ terraform init
Initializing the backend...

Initializing modules...
- vpc in modules/vpc

Initializing provider plugins...
- Finding hashicorp/aws versions matching ">= 6.0.0, ~> 6.0, < 7.0.0"...
- Installing hashicorp/aws v6.64.0...
- Installed hashicorp/aws v6.64.0 (signed by HashiCorp)

Terraform has created a lock file .terraform.lock.hcl to record the provider
selections it made above. Include this file in your version control repository
so that Terraform can guarantee to make the same selections by default when
you run "terraform init" in the future.

Terraform has been successfully initialized!

You may now begin working with Terraform. Try running "terraform plan" to see
any changes that are required for your infrastructure. All Terraform commands
should now work.

If you ever set or change modules or backend configuration for Terraform,
rerun this command to reinitialize your working directory. If you forget, other
commands will detect it and remind you to do so if necessary.
dev@DESKTOP-P6CCGSP:~/Projet_aws_terraform$ 
```

```bash
dev@DESKTOP-P6CCGSP:~/Projet_aws_terraform$ terraform plan -out=exercice1.tfplan

Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the following symbols:
  + create

Terraform will perform the following actions:

  # module.vpc.aws_subnet.private will be created
  + resource "aws_subnet" "private" {
      + arn                                            = (known after apply)
      + assign_ipv6_address_on_creation                = false
      + availability_zone                              = "eu-west-3a"
      + availability_zone_id                           = (known after apply)
      + cidr_block                                     = "10.0.11.0/24"
      + enable_dns64                                   = false
      + enable_resource_name_dns_a_record_on_launch    = false
      + enable_resource_name_dns_aaaa_record_on_launch = false
      + id                                             = (known after apply)
      + ipv6_cidr_block                                = (known after apply)
      + ipv6_cidr_block_association_id                 = (known after apply)
      + ipv6_native                                    = false
      + map_public_ip_on_launch                        = false
      + owner_id                                       = (known after apply)
      + private_dns_hostname_type_on_launch            = (known after apply)
      + region                                         = "eu-west-3"
      + tags                                           = {
          + "Name" = "tp-06-prive-a"
        }
      + tags_all                                       = {
          + "Name" = "tp-06-prive-a"
        }
      + vpc_id                                         = (known after apply)
    }

  # module.vpc.aws_subnet.public will be created
  + resource "aws_subnet" "public" {
      + arn                                            = (known after apply)
      + assign_ipv6_address_on_creation                = false
      + availability_zone                              = "eu-west-3a"
      + availability_zone_id                           = (known after apply)
      + cidr_block                                     = "10.0.1.0/24"
      + enable_dns64                                   = false
      + enable_resource_name_dns_a_record_on_launch    = false
      + enable_resource_name_dns_aaaa_record_on_launch = false
      + id                                             = (known after apply)
      + ipv6_cidr_block                                = (known after apply)
      + ipv6_cidr_block_association_id                 = (known after apply)
      + ipv6_native                                    = false
      + map_public_ip_on_launch                        = true
      + owner_id                                       = (known after apply)
      + private_dns_hostname_type_on_launch            = (known after apply)
      + region                                         = "eu-west-3"
      + tags                                           = {
          + "Name" = "tp-06-public-a"
        }
      + tags_all                                       = {
          + "Name" = "tp-06-public-a"
        }
      + vpc_id                                         = (known after apply)
    }

  # module.vpc.aws_vpc.this will be created
  + resource "aws_vpc" "this" {
      + arn                                  = (known after apply)
      + cidr_block                           = "10.0.0.0/16"
      + default_network_acl_id               = (known after apply)
      + default_route_table_id               = (known after apply)
      + default_security_group_id            = (known after apply)
      + dhcp_options_id                      = (known after apply)
      + enable_dns_hostnames                 = true
      + enable_dns_support                   = true
      + enable_network_address_usage_metrics = (known after apply)
      + id                                   = (known after apply)
      + instance_tenancy                     = "default"
      + ipv6_association_id                  = (known after apply)
      + ipv6_cidr_block                      = (known after apply)
      + ipv6_cidr_block_network_border_group = (known after apply)
      + main_route_table_id                  = (known after apply)
      + owner_id                             = (known after apply)
      + region                               = "eu-west-3"
      + tags                                 = {
          + "Name" = "tp-06-vpc"
        }
      + tags_all                             = {
          + "Name" = "tp-06-vpc"
        }
    }

Plan: 3 to add, 0 to change, 0 to destroy.

Changes to Outputs:
  + numero_poste      = "06"
  + private_subnet_id = (known after apply)
  + public_subnet_id  = (known after apply)
  + vpc_id            = (known after apply)

──────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────

Saved the plan to: exercice1.tfplan

To perform exactly these actions, run the following command to apply:
    terraform apply "exercice1.tfplan"
dev@DESKTOP-P6CCGSP:~/Projet_aws_terraform$
```

