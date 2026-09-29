# Azure Storage backend for the lab (dev).
# Storage account name must be globally unique — change it if create fails.
# Bootstrap once: ./scripts/bootstrap-backend.sh

resource_group_name  = "rg-lab-tfstate"
storage_account_name = "stlabtfstatedev01"
container_name       = "tfstate"
key                  = "dev/lab-terraform.tfstate"
