resource_group_name           = "rg-lab-terraform-dev"
location                      = "eastus"
virtual_network_name          = "rg-lab-terraform-dev-vnet"
virtual_network_address_space = ["10.0.0.0/16"]
tags = {
  Environment = "dev"
  Project     = "lab-terraform"
  ManagedBy   = "terraform"
}
